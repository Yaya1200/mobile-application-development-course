import 'package:campus_companion/exercises/lecture_check_in_by_hand.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the provider written by hand works like the generated one', () {
    final container = ProviderContainer.test();
    final counter = container.read(checkInCounterProvider.notifier);

    counter.checkIn();
    expect(container.read(checkInCounterProvider), 1);

    counter.reset();
    expect(container.read(checkInCounterProvider), 0);
  });
}
