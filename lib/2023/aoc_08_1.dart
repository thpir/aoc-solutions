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
  var currentLocation = "AAA";
  var finalLocation = "ZZZ";
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
      if (currentLocation == finalLocation) {
        atDestination = true;
        break;
      }
    }
  }
  return steps;
}