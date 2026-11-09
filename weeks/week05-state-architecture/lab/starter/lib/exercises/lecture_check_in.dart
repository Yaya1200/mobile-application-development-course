// Week 5 lecture example — a check-in counter on a provider. This is the
// end state of the live coding. The lab task it is paired with is
// different: in the lab you move the *profile* onto profileProvider.
//
//   CheckInCounter (a Notifier, int)    <->  ProfileNotifier (given)
//   CheckInPage + CheckInBadge watch it <->  ProfileScreen + AppDrawer
//
// The same provider written without the generator is in
// lecture_check_in_by_hand.dart. Compare the two files.
//
// Run it on its own:
//   flutter run -d chrome -t lib/exercises/lecture_check_in.dart
// The tests are in test/exercises/lecture_check_in_test.dart.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lecture_check_in.g.dart';

void main() => runApp(const ProviderScope(child: CheckInApp()));

@riverpod
class CheckInCounter extends _$CheckInCounter {
  @override
  int build() => 0;

  void checkIn() => state = state + 1;

  void reset() => state = 0;
}

class CheckInApp extends StatelessWidget {
  const CheckInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Check-in', home: CheckInPage());
  }
}

/// Watches the counter in `build` and changes it in a callback.
class CheckInPage extends ConsumerWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(checkInCounterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-in'),
        actions: const [CheckInBadge()],
      ),
      body: Center(child: Text('Check-ins today: $count')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Check in',
        // ref.read in a callback: one action, no subscription.
        onPressed: () => ref.read(checkInCounterProvider.notifier).checkIn(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// A second widget that shows the same value. With `setState` in
/// CheckInPage, this widget could not see the count.
class CheckInBadge extends ConsumerWidget {
  const CheckInBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(checkInCounterProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Chip(label: Text('$count')),
    );
  }
}
