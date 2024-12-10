int getSolution(List<String> file) {
  int result = 0;
  List<List<int>> input = surroundWithNegativeOnes(file
      .map((line) => line.split('').map((char) => int.parse(char)).toList())
      .toList());
  List<Map<String, int>> trailheads = findPosibleDirections(input, 0);
  for (var trailhead in trailheads) {
    List<List<int>> mapWithReachtedEndpoints = List.generate(
      input.length,
      (i) => List.filled(input[i].length, 0),
    );
    result += calculateTrailheadScore(trailhead, input, mapWithReachtedEndpoints);
  }
  return result;
}

int calculateTrailheadScore(Map<String, int> locationOnMap, List<List<int>> input,
    List<List<int>> endPoints) {
  findNextStep(locationOnMap, input, endPoints, 1);
  return endPoints.expand((row) => row).where((number) => number == 9).length;
}

void findNextStep(Map<String, int> locationOnMap, List<List<int>> input,
    List<List<int>> endPoints, int numberToFind) {
  List<Map<String, int>> possibleDirections =
      scanGridAroundLocation(locationOnMap, input, numberToFind);
  if (numberToFind == 9) {
    for (var possibleDirection in possibleDirections) {
      endPoints[possibleDirection['x']!][possibleDirection['y']!] = 9;
    }
  } else {
    for (var possibleDirection in possibleDirections) {
      findNextStep(possibleDirection, input, endPoints, numberToFind + 1);
    }
  }
}

List<Map<String, int>> scanGridAroundLocation(
    Map<String, int> location, List<List<int>> input, int numberToFind) {
  List<Map<String, int>> possibleDirections = [];
  if (input[location['y']!][location['x']! - 1] == numberToFind) {
    possibleDirections.add({
      'x': location['x']! - 1,
      'y': location['y']!,
    });
  }
  if (input[location['y']! - 1][location['x']!] == numberToFind) {
    possibleDirections.add({
      'x': location['x']!,
      'y': location['y']! - 1,
    });
  }
  if (input[location['y']! + 1][location['x']!] == numberToFind) {
    possibleDirections.add({
      'x': location['x']!,
      'y': location['y']! + 1,
    });
  }
  if (input[location['y']!][location['x']! + 1] == numberToFind) {
    possibleDirections.add({
      'x': location['x']! + 1,
      'y': location['y']!,
    });
  }
  return possibleDirections;
}

List<Map<String, int>> findPosibleDirections(
    List<List<int>> input, int numberTofind) {
  List<Map<String, int>> possibleDirections = [];
  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input[y].length; x++) {
      if (input[y][x] == numberTofind) {
        possibleDirections.add({
          'x': x,
          'y': y,
        });
      }
    }
  }
  return possibleDirections;
}

List<List<int>> surroundWithNegativeOnes(List<List<int>> matrix) {
  final rows = matrix.length;
  final cols = matrix[0].length;

  // Create a new matrix with extra rows and columns
  final newMatrix = List.generate(rows + 2, (_) => List.filled(cols + 2, -1));

  // Copy the original matrix into the new matrix, offsetting by 1
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      newMatrix[i + 1][j + 1] = matrix[i][j];
    }
  }

  return newMatrix;
}
