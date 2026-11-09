// Week 1 lecture examples — the worked examples shown in the notes and
// slides. Read them; do not copy them into the exercises. Each lab exercise
// in dart_basics.dart is similar to one example here, but not the same.
//
// The tests in test/exercises/lecture_examples_test.dart show what each
// example returns.

/// Converts a 0–100 score to a letter: A ≥ 90, B ≥ 80, C ≥ 70, D ≥ 60,
/// otherwise F. Throws [ArgumentError] if the score is outside 0–100.
String gradeLetter(double score) {
  if (score < 0 || score > 100) {
    throw ArgumentError.value(score, 'score', 'must be between 0 and 100');
  }
  return switch (score) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    >= 60 => 'D',
    _ => 'F',
  };
}
 
/// Returns the sum of the even numbers in [numbers]. Empty list → 0.
int sumOfEvens(List<int> numbers) {
  return numbers.where((n) => n.isEven).fold(0, (sum, n) => sum + n);
}

/// Counts how many times each word occurs in [sentence]. Words are
/// separated by whitespace and compared case-insensitively.
Map<String, int> wordCount(String sentence) {
  final counts = <String, int>{};
  for (final word in sentence.toLowerCase().split(RegExp(r'\s+'))) {
    if (word.isEmpty) continue;
    counts.update(word, (n) => n + 1, ifAbsent: () => 1);
  }
  return counts;
}

/// Converts a temperature. [value] is in Celsius by default; pass
/// `toCelsius: true` to convert from Fahrenheit to Celsius instead.
/// The result is rounded to one decimal place.
double convertTemperature(double value, {bool toCelsius = false}) {
  final result = toCelsius ? (value - 32) * 5 / 9 : value * 9 / 5 + 32;
  return (result * 10).roundToDouble() / 10;
}

/// Describes a value that may be null or of any type.
String describe(Object? value) {
  return switch (value) {
    null => 'nothing',
    final int n => 'the integer $n',
    final String s => 'the text "$s"',
    final List<Object?> items => 'a list of ${items.length} items',
    _ => 'something else',
  };
}
