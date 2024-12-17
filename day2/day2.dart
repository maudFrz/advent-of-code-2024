import 'dart:io';

void main(List<String> args) async {
  final String realInputPath = 'day2/real_input.txt';

  final String exampleInputPath = 'day2/example_input.txt';

  final String rawContent = await File(realInputPath).readAsString();

  final List<Report> reports = parseData(rawContent);

  final int result = reports.fold(
    0,
    ((previousValue, element) =>
        element.isSafe ? previousValue + 1 : previousValue),
  );

  print('There are $result safe reports');

  // final int result2 = elements.fold(
  //   0,
  //   ((previousValue, element) =>
  //       element.isOverlap() ? previousValue + 1 : previousValue),
  // );

  // print(
  //   'There are',
  // );
}

List<Report> parseData(String rawContent) => rawContent
    .split('\n')
    .map((String line) => ReportModel.parse(line))
    .toList(growable: false);

class Report {
  const Report(this.levels);

  final List<int> levels;

  bool get isSafe {
    bool isIncreasing = levels[0] < levels[1];
    for (int i = 0; i < levels.length - 1; i++) {
      if (isIncreasing
          ? levels[i] >= levels[i + 1]
          : levels[i] <= levels[i + 1]) return false;

      switch ((levels[i + 1] - levels[i]).abs()) {
        case < 1:
          return false;
        case > 3:
          return false;
      }
    }

    return true;
  }
}

class ReportModel extends Report {
  const ReportModel(super.levels);

  factory ReportModel.parse(String line) {
    final List<String> split = line.split(' ');
    return ReportModel(
      split.map((el) => int.parse(el)).toList(growable: false),
    );
  }
}
