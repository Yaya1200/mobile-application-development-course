import 'package:campus_companion/core/router/router.dart';
import 'package:campus_companion/features/profile/data/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  test('setName trims and ignores empty input', () {
    final container = ProviderContainer.test();
    final notifier = container.read(profileProvider.notifier);

    notifier.setName('  Hana  ');
    expect(container.read(profileProvider).name, 'Hana');

    notifier.setName('   ');
    expect(container.read(profileProvider).name, 'Hana');
  });

  testWidgets('editing the name updates the provider and the screen',
      (tester) async {
    await pumpApp(tester, initialLocation: Routes.profile);
    expect(find.text('Sara Bekele'), findsOneWidget);

    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Hana Tadesse');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Hana Tadesse'), findsOneWidget);
  });

  // TODO(lab): Task 3 — write this test before you change ProfileScreen,
  // and run it to see it fail. Start the app at Routes.profile with
  // profileProvider overridden to a profile of your own (a name, a
  // programme and a year that are not the defaults). Expect the screen to
  // show all three. The worked example is the override test in
  // test/exercises/lecture_reminders_test.dart.
}
