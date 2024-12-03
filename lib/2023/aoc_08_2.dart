import 'package:dart_numerics/dart_numerics.dart' as numerics;

class Node {
  final String location;
  final List<String> destination;

  Node(this.location, this.destination);
}

List<Node> getNodes(List<String> file) {
  file.removeAt(0);
  file.removeAt(0);
  return file.map((line) {
    var lineparts = line.split(' = ');
    return Node(lineparts[0],
        [lineparts[1].substring(1, 4), lineparts[1].substring(6, 9)]);
  }).toList();
}

int getSolution(List<String> file) {
  String instructions = file[0];
  List<Node> nodes = getNodes(file);
  List<String> currentLocations = [
    for (Node node in nodes)
      if (node.location.endsWith("A")) node.location
  ];
  List<int> stepList = [];
  print(currentLocations);
  for (String currentLocation in currentLocations) {
    print("Finding steps for $currentLocation");
    var atDestination = false;
    var steps = 0;
    while (!atDestination) {
      for (int i = 0; i < instructions.length; i++) {
        if (instructions[i] == 'L') {
          currentLocation = nodes
              .firstWhere((element) =>
                  element.location ==
                  nodes
                      .firstWhere(
                          (element) => element.location == currentLocation)
                      .destination[0])
              .location;
        } else {
          currentLocation = nodes
              .firstWhere((element) =>
                  element.location ==
                  nodes
                      .firstWhere(
                          (element) => element.location == currentLocation)
                      .destination[1])
              .location;
        }
        steps++;
        if (currentLocation.endsWith("Z")) {
          atDestination = true;
          break;
        }
      }
    }
    stepList.add(steps);
  }
  return findLCM(stepList);
}

int findLCM(List<int> numbers) {
  late int lcm;
  if (numbers.length == 1) {
    lcm = numbers[0];
  } else {
    lcm = leastCommonMultiple(numbers[0], numbers[1]);
    if (numbers.length > 2) {
      for (int i = 2; i < numbers.length; i++) {
        lcm = leastCommonMultiple(lcm, numbers[i]);
      }
    }
  }
  return lcm;
}

int leastCommonMultiple(int a, int b) {
  if ((a == 0) || (b == 0)) {
    return 0;
  }

  return ((a ~/ numerics.greatestCommonDivisor(a, b)) * b).abs();
}
