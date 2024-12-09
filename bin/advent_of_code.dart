import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:advent_of_code/2024/aoc_09_2.dart' as aoc;

void main(List<String> arguments) {
  print(aoc.getSolution(getFile()));
}

List<String> getFile() {
  var filePath =
      p.join(Directory.current.path, 'assets/2024', 'input_aoc_9_1.txt');
  File file = File(filePath);
  print(file.path);
  return file.readAsLinesSync();
}
