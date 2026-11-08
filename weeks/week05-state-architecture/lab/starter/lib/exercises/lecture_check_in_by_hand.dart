// Week 5 lecture example — the check-in counter provider written WITHOUT
// the code generator. Read it; you do not write providers this way in
// the course. It shows what the generator writes for you in
// lecture_check_in.g.dart, in a shorter form.
//
// Compare with lecture_check_in.dart:
//   - the class extends Notifier<int> instead of _$CheckInCounter;
//   - there is no `part` line and no .g.dart file;
//   - the provider is one line that you write yourself.
//
// The tests are in test/exercises/lecture_check_in_by_hand_test.dart.

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckInCounter extends Notifier<int> {
  @override
  int build() => 0;

  void checkIn() => state = state + 1;

  void reset() => state = 0;
}

// The generator writes this line for you. `autoDispose`: the count is
// thrown away when no widget watches it any more; `@riverpod` does the
// same by default.
final checkInCounterProvider =
    NotifierProvider.autoDispose<CheckInCounter, int>(CheckInCounter.new);
