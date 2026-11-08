import 'package:campus_companion/exercises/lecture_reminders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  late Reminders reminders;

  setUp(() {
    container = ProviderContainer.test();
    reminders = container.read(remindersProvider.notifier);
  });

  test('add appends a reminder with a generated id', () {
    final r = reminders.add('Return books', due: DateTime(2026, 3, 2));

    expect(r.id, 'r1');
    expect(container.read(remindersProvider), [r]);
  });

  test('markDone replaces the reminder with a done copy', () {
    final r = reminders.add('Pay fee', due: DateTime(2026, 3, 2));

    reminders.markDone(r.id);

    expect(container.read(reminderByIdProvider(r.id))!.done, isTrue);
    expect(r.done, isFalse, reason: 'the old object does not change');
  });

  test('openReminders hides done ones and puts the soonest first', () {
    final later = reminders.add('Later', due: DateTime(2026, 3, 9));
    final sooner = reminders.add('Sooner', due: DateTime(2026, 3, 1));
    final done = reminders.add('Done', due: DateTime(2026, 2, 1));
    reminders.markDone(done.id);

    expect(container.read(openRemindersProvider), [sooner, later]);
    expect(
      container.read(remindersProvider).map((r) => r.text),
      ['Later', 'Sooner', 'Done'],
      reason: 'sorting works on a copy; the state keeps its order',
    );
  });

  test('remove deletes by id', () {
    final a = reminders.add('A', due: DateTime(2026, 3, 1));
    final b = reminders.add('B', due: DateTime(2026, 3, 2));

    reminders.remove(a.id);

    expect(container.read(remindersProvider), [b]);
  });

  test('the state cannot be changed in place', () {
    reminders.add('A', due: DateTime(2026, 3, 1));

    expect(
      () => container.read(remindersProvider).clear(),
      throwsUnsupportedError,
    );
  });

  testWidgets('an override fills the page with known reminders', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          remindersProvider.overrideWithValue([
            Reminder(id: 'x', text: 'Second', due: DateTime(2026, 3, 2)),
            Reminder(id: 'y', text: 'First', due: DateTime(2026, 3, 1)),
          ]),
        ],
        child: const RemindersApp(),
      ),
    );

    final first = tester.getTopLeft(find.text('First'));
    final second = tester.getTopLeft(find.text('Second'));
    expect(first.dy, lessThan(second.dy));
  });

  testWidgets('adding and ticking a reminder updates the list', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: RemindersApp()));
    expect(find.text('Nothing to do.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Buy ink');
    await tester.tap(find.byTooltip('Add'));
    await tester.pump();
    expect(find.text('Buy ink'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('Nothing to do.'), findsOneWidget);
  });
}
