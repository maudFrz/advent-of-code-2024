import 'dart:io';

void main(List<String> args) async {
  final String realInputPath = 'day3/real_input.txt';

  final String exampleInputPath = 'day3/example_input.txt';

  final String rawContent = await File(realInputPath).readAsString();

  final RegExp regexp = RegExp(r'mul\(([0-9]+),([0-9]+)\)');

  final Iterable<RegExpMatch> matches = regexp.allMatches(rawContent);

  int result = 0;
  matches.forEach((RegExpMatch match) =>
      result += int.parse(match.group(1)!) * int.parse(match.group(2)!));

  print('First half result : $result');
}
