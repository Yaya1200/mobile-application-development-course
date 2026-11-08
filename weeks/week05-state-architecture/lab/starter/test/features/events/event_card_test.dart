import 'package:campus_companion/features/events/domain/event.dart';
import 'package:campus_companion/features/events/presentation/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final event = Event(
    id: 'x',
    title: 'Flutter study group',
    start: DateTime(2026, 10, 14, 16),
    venue: Venue.technology,
    description: 'Layouts and constraints.',
  );

  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('shows date, title, venue and description', (tester) async {
    await tester.pumpWidget(wrap(EventCard(event: event)));

    expect(find.text('14'), findsOneWidget);
    expect(find.text('Oct'), findsOneWidget);
    expect(find.text('Flutter study group'), findsOneWidget);
    expect(find.text('Layouts and constraints.'), findsOneWidget);
  });

  testWidgets('shows a Free chip only for free events', (tester) async {
    await tester.pumpWidget(wrap(EventCard(event: event)));
    expect(find.text('Free'), findsOneWidget);

    await tester.pumpWidget(wrap(EventCard(event: event.copyWith(isFree: false))));
    expect(find.text('Free'), findsNothing);
  });

  testWidgets('a very long title does not overflow', (tester) async {
    final long = event.copyWith(title: 'A very long title ' * 10);
    await tester.pumpWidget(wrap(SizedBox(width: 320, child: EventCard(event: long))));
    expect(tester.takeException(), isNull);
  });

  test('freezed gives value equality and copyWith', () {
    expect(event, equals(event.copyWith()));
    expect(event.copyWith(title: 'x'), isNot(equals(event)));
    expect(event.isUpcoming(now: DateTime(2026, 10, 1)), isTrue);
  });
}
