import 'package:campus_companion/core/presentation/about_screen.dart';
import 'package:campus_companion/features/events/data/sample_events.dart';
import 'package:campus_companion/features/events/presentation/event_detail_screen.dart';
import 'package:campus_companion/features/events/presentation/events_screen.dart';
import 'package:campus_companion/features/notes/presentation/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  testWidgets('bottom navigation switches sections', (tester) async {
    await pumpApp(tester);
    expect(find.byType(EventsScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.note_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(NotesScreen), findsOneWidget);
  });

  testWidgets('tapping a card opens the detail; back returns', (tester) async {
    await pumpApp(tester);
    final first = sampleEvents.first;

    await tester.tap(find.text(first.title));
    await tester.pumpAndSettle();
    expect(find.byType(EventDetailScreen), findsOneWidget);
    expect(find.text(first.description), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(EventsScreen), findsOneWidget);
  });

  testWidgets('deep link to an unknown event shows not found', (tester) async {
    await pumpApp(tester, initialLocation: '/events/nope');
    expect(find.text('Event not found'), findsOneWidget);
  });

  testWidgets('drawer opens About', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();
    expect(find.byType(AboutScreen), findsOneWidget);
  });
}
