import 'package:test/test.dart';
import 'day2.dart';

void main() {
  test('should detect safe report with increasing levels.', () {
    final Report report = Report(<int>[1, 3, 6, 7, 9]);

    final bool isSafe = report.isSafe;

    expect(isSafe, isTrue);
  });

  test('should detect safe report with decreasing levels.', () {
    final Report report = Report(<int>[9, 7, 6, 3, 1]);

    final bool isSafe = report.isSafe;

    expect(isSafe, isTrue);
  });

  test(
    'should detect unsafe report with increasing levels, but too far spaced.',
    () {
      final Report report = Report(<int>[1, 3, 6, 7, 19]);

      final bool isSafe = report.isSafe;

      expect(isSafe, isFalse);
    },
  );

  test(
    'should detect unsafe report with decreasing levels, but too far spaced.',
    () {
      final Report report = Report(<int>[19, 17, 6, 3, 1]);

      final bool isSafe = report.isSafe;

      expect(isSafe, isFalse);
    },
  );

  test(
    'should detect unsafe report with both increasing and decreasing levels',
    () {
      final Report report = Report(<int>[1, 3, 6, 7, 9, 7, 5]);

      final bool isSafe = report.isSafe;

      expect(isSafe, isFalse);
    },
  );

  test(
    'should detect unsafe report when 2 levels are equals',
    () {
      final Report report = Report(<int>[1, 3, 6, 7, 7, 9]);

      final bool isSafe = report.isSafe;

      expect(isSafe, isFalse);
    },
  );
}
