import 'package:campus_companion/exercises/dart_basics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fizzBuzz', () {
    test('returns the number when not divisible by 3 or 5', () {
      expect(fizzBuzz(1), '1');
      expect(fizzBuzz(7), '7');
    });
    test('handles multiples of 3, 5 and 15', () {
      expect(fizzBuzz(9), 'Fizz');
      expect(fizzBuzz(10), 'Buzz');
      expect(fizzBuzz(30), 'FizzBuzz');
    });
  });

  group('averageOfPositives', () {
    test('averages only the numbers greater than zero', () {
      expect(averageOfPositives([1, -2, 3]), 2);
      expect(averageOfPositives([4, 0, 6]), 5);
    });
    test('returns 0 when there are no positive numbers', () {
      expect(averageOfPositives([]), 0);
      expect(averageOfPositives([-1, 0]), 0);
    });
  });

  group('bmiCategory', () {
    test('maps a value to its category', () {
      expect(bmiCategory(17), 'Underweight');
      expect(bmiCategory(22.4), 'Normal');
      expect(bmiCategory(27), 'Overweight');
      expect(bmiCategory(35), 'Obese');
    });
    test('rejects zero and negative values', () {
      expect(() => bmiCategory(0), throwsArgumentError);
      expect(() => bmiCategory(-5), throwsArgumentError);
    });
    test('checking the bmi value',()=> {
      expect(bmiCategory(25), "Overweight")
    });
    // TODO(lab): Exercise 3 — before you write bmiCategory, add your own
    // test here for a value exactly on a boundary (for example 25.0).
    // Run it and watch it fail. Show the failing test to the TA at
    // Checkpoint B, then make it pass.
  });

  group('isPalindrome', () {
    test('ignores case and punctuation', () {
      expect(isPalindrome('A man, a plan, a canal: Panama'), isTrue);
      expect(isPalindrome('Racecar'), isTrue);
    });
    test('detects non-palindromes', () {
      expect(isPalindrome('Flutter'), isFalse);
    });
  });

  group('letterCount', () {
    test('counts letters case-insensitively', () {
      expect(letterCount('Hello, World!'), {
        'h': 1,
        'e': 1,
        'l': 3,
        'o': 2,
        'w': 1,
        'r': 1,
        'd': 1,
      });
    });
    test('ignores digits, spaces and punctuation', () {
      expect(letterCount('a1 b2 A!'), {'a': 2, 'b': 1});
      expect(letterCount('123 ?!'), isEmpty);
    });
  });

  group('convertDistance', () {
    test('converts kilometres to miles by default', () {
      expect(convertDistance(10), 6.2);
      expect(convertDistance(42.195), 26.2);
    });
    test('converts miles to kilometres when asked', () {
      expect(convertDistance(26.2, toKilometres: true), 42.2);
      expect(convertDistance(1, toKilometres: true), 1.6);
    });
  });

  group('fibonacci', () {
    test('returns the first n numbers', () {
      expect(fibonacci(8), [0, 1, 1, 2, 3, 5, 8, 13]);
    });
    test('returns an empty list for count <= 0', () {
      expect(fibonacci(0), isEmpty);
      expect(fibonacci(-3), isEmpty);
    });
  });

  group('summarise', () {
    test('summarises each kind of value', () {
      expect(summarise(null), 'no value');
      expect(summarise(true), 'yes');
      expect(summarise(false), 'no');
      expect(summarise(3.5), 'a decimal number');
      expect(summarise('hi'), '"hi" has 2 characters');
      expect(summarise({'a': 1, 'b': 2, 'c': 3}), 'a map with 3 entries');
      expect(summarise({1, 2}), 'unknown');
    });
  });
}
