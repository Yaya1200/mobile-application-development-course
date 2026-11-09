import 'package:campus_companion/exercises/lecture_check_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('checkIn adds one and reset goes back to zero', () {
    final container = ProviderContainer.test();
    final counter = container.read(checkInCounterProvider.notifier);

    counter.checkIn();
    counter.checkIn();
    expect(container.read(checkInCounterProvider), 2);

    counter.reset();
    expect(container.read(checkInCounterProvider), 0);
  });

  testWidgets('the page and the badge show the same count', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CheckInApp()));
    expect(find.text('Check-ins today: 0'), findsOneWidget);

    await tester.tap(find.byTooltip('Check in'));
    await tester.pump();

    expect(find.text('Check-ins today: 1'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(CheckInBadge), matching: find.text('1')),
      findsOneWidget,
    );
  });

  testWidgets('an override starts the counter at another value', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [checkInCounterProvider.overrideWithValue(7)],
        child: const CheckInApp(),
      ),
    );

    expect(find.text('Check-ins today: 7'), findsOneWidget);
    expect(find.widgetWithText(Chip, '7'), findsOneWidget);
  });
}
