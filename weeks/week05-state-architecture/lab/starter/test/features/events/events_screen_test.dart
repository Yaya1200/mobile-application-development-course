import 'package:campus_companion/features/events/data/events_providers.dart';
import 'package:campus_companion/features/events/data/events_repository.dart';
import 'package:campus_companion/features/events/data/sample_events.dart';
import 'package:campus_companion/features/events/presentation/event_card.dart';
import 'package:campus_companion/features/events/presentation/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  Widget screen({
    required EventsRepository repo,
    double width = 360,
    DateTime? now,
  }) {
    return ProviderScope(
      overrides: [
        eventsRepositoryProvider.overrideWithValue(repo),
        nowProvider.overrideWithValue(now ?? testClock),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(width: width, height: 800, child: const EventsScreen()),
          ),
        ),
      ),
    );
  }

  testWidgets('shows a spinner while loading, then the list', (tester) async {
    await tester.pumpWidget(
      screen(repo: InMemoryEventsRepository(delay: const Duration(seconds: 1))),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(sampleEvents.first.title), findsOneWidget);
  });

  testWidgets('shows an error with retry when loading fails', (tester) async {
    await tester.pumpWidget(screen(repo: FakeEventsRepository(fail: true)));
    await tester.pumpAndSettle();

    expect(find.textContaining('Could not load events'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('narrow width uses a ListView, wide uses a GridView',
      (tester) async {
    await tester.pumpWidget(screen(repo: FakeEventsRepository(), width: 360));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);

    await tester.pumpWidget(screen(repo: FakeEventsRepository(), width: 700));
    await tester.pumpAndSettle();
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(EventCard), findsWidgets);
  });

  testWidgets('Upcoming and Past split the feed by the clock provider',
      (tester) async {
    await tester.pumpWidget(
      screen(repo: FakeEventsRepository(), now: DateTime(2026, 10, 20)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Guest lecture: mobile money at scale'), findsOneWidget);
    expect(find.text('Flutter study group'), findsNothing);

    await tester.tap(find.text('Past'));
    await tester.pumpAndSettle();
    expect(find.text('Flutter study group'), findsOneWidget);
  });
}
