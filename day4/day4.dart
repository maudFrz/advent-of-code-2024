import 'dart:io';

void main(List<String> args) async {
  final String realInputPath = 'day4/real_input.txt';

  final String exampleInputPath = 'day4/example_input.txt';

  final String rawContent = await File(realInputPath).readAsString();

  final List<List<String>> grid =
      rawContent.split('\n').map((line) => line.split('')).toList();

  final List<String> xmasLetters = 'XMAS'.split('');

  int xmasOccurrences = 0;
  int crossMasOccurences = 0;

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid.first.length; j++) {
      // First half - xmas detection
      if (grid[i][j] == xmasLetters.first) {
        for (wordDirection direction in wordDirection.values) {
          if (isWrittenInGivenDirection(grid, i, j, xmasLetters, direction)) {
            xmasOccurrences++;
          }
        }
      }

      // Second half - cross mas direction
      if (grid[i][j] == 'A' && isMasWrittenInCross(grid, i, j)) {
        crossMasOccurences++;
      }
    }
  }

  print(
    'There are $xmasOccurrences ocurrences of the word XMAS',
  );

  print(
    'There are $crossMasOccurences ocurrences of the word MAS in cross',
  );
}

bool isWrittenInGivenDirection(List<List<String>> grid, int i, int j,
    List<String> word, wordDirection direction) {
  for (int n = 0; n < word.length; n++) {
    int a = i + n * direction.verticalModificator;
    int b = j + n * direction.horizontalModificator;
    if (a < 0 || a >= grid.length || b < 0 || b >= grid.first.length)
      return false;
    if (grid[a][b] != word[n]) {
      return false;
    }
  }
  return true;
}

bool isMasWrittenInCross(List<List<String>> grid, int i, int j) {
  final List<String> word = 'MAS'.split('');

  int count = 0;
  for (wordDirection direction in wordDirection.allDiagonals) {
    if (isWrittenInGivenDirection(grid, i - direction.verticalModificator,
        j - direction.horizontalModificator, word, direction)) {
      count++;
    }
  }

  return count >= 2;
}

enum wordDirection {
  up,
  down,
  right,
  left,
  upRight,
  upLeft,
  downRight,
  downLeft;

  static List<wordDirection> get allDiagonals =>
      <wordDirection>[upRight, upLeft, downRight, downLeft];

  int get horizontalModificator => switch (this) {
        wordDirection.up || wordDirection.down => 0,
        wordDirection.right ||
        wordDirection.upRight ||
        wordDirection.downRight =>
          1,
        wordDirection.left ||
        wordDirection.upLeft ||
        wordDirection.downLeft =>
          -1,
      };

  int get verticalModificator => switch (this) {
        wordDirection.right || wordDirection.left => 0,
        wordDirection.down ||
        wordDirection.downRight ||
        wordDirection.downLeft =>
          1,
        wordDirection.up || wordDirection.upRight || wordDirection.upLeft => -1,
      };
}
