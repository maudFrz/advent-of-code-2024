import 'dart:io';
import 'package:collection/collection.dart';

void main(List<String> args) async {
  final String realInputPath = 'day1/real_input.txt';

  final String exampleInputPath = 'day1/example_input.txt';

  final String rawContent = await File(realInputPath).readAsString();

  final List<int> rightValues = [];
  final List<int> leftValues = [];

  rawContent.split('\n').forEach((String line) {
    final List<String> split = line.split('   ');
    rightValues.add(int.parse(split[0]));
    leftValues.add(int.parse(split[1]));
  });

  rightValues.sort();
  leftValues.sort();

  final List<int> distances = [];

  rightValues.forEachIndexed(
      (index, item) => distances.add((leftValues[index] - item).abs()));

  print(
    'Sum of all distances is : ${distances.sum};',
  );

  final List<int> similarities = [];

  rightValues.forEach((value) => similarities
      .add(value * leftValues.where((leftValue) => leftValue == value).length));

  print(
    'Similarity of all values is : ${similarities.sum};',
  );
}
