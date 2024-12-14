late List<List<String>> input;
late List<List<String>> visited;

enum Direction { up, down, left, right }

int getSolution(List<String> file) {
  int totalPrice = 0;
  input = surroundWithHashTags(
      file.map((line) => line.split('').map((char) => char).toList()).toList());
  visited = List.generate(
    input.length,
    (i) => List.filled(input[i].length, '.'),
  );
  for (int y = 1; y < input.length - 1; y++) {
    for (int x = 1; x < input[x].length - 1; x++) {
      if (visited[y][x] == "#") {
        continue;
      } else {
        totalPrice += findRegionPrice(y, x);
      }
    }
  }
  return totalPrice;
}

int findRegionPrice(int y, int x) {
  String regionId = input[y][x];
  List<List<String>> region = List.generate(
    input.length,
    (i) => List.filled(input[i].length, '.'),
  );
  findRegion(y, x, regionId, region);
  int area = region.fold(
      0,
      (previousValue, element) =>
          previousValue + element.where((e) => e == regionId).length);
  int perimeter = calculateEdges(region);
  return area * perimeter;
}

int calculateEdges(List<List<String>> region) {
  int horizontalEdges = 0;
  int verticalEdges = 0;

  // Step 1: 
  //   a. between each row add an empty row
  //   b. if same character up and down, just copy, else "-"
  List<List<String>> regionCopyForHorizontalEdges = [];
  for (var i = 0; i < region.length - 1; i++) {
    regionCopyForHorizontalEdges.add(region[i]);
    if (i != region.length - 1) {
      List<String> row = [];
      for (var j = 0; j < region[i].length; j++) {
        if (region[i][j] == region[i + 1][j]) {
          row.add(region[i][j]);
        } else {
          row.add("-");
        }
      }
      regionCopyForHorizontalEdges.add(row);
    }
  }
  regionCopyForHorizontalEdges.add(region[region.length - 1]);

  // Step 2:
  //   a. between each character in a row add a new space
  //   b. if same character left and right, just copy, else "|"
  List<List<String>> regionCopyForVerticalEdges = List.generate(regionCopyForHorizontalEdges.length, (_) => <String>[]);
  for (var i = 0; i < regionCopyForHorizontalEdges[0].length - 1; i++) {
    for (var j = 0; j < regionCopyForHorizontalEdges.length; j++) {
      regionCopyForVerticalEdges[j].add(regionCopyForHorizontalEdges[j][i]);
      if (regionCopyForHorizontalEdges[j][i] == regionCopyForHorizontalEdges[j][i + 1]) {
        regionCopyForVerticalEdges[j].add(regionCopyForHorizontalEdges[j][i]);
      } else {
        regionCopyForVerticalEdges[j].add("|");
      }
    }
  }
  for (var j = 0; j < regionCopyForVerticalEdges.length; j++) {
    regionCopyForVerticalEdges[j].add(regionCopyForHorizontalEdges[j][regionCopyForHorizontalEdges[j].length - 1]);
  }

  // Step 3:
  //   a. for each "|" that has a "-" left or right. replace by "+"
  //   b. for each "-" that has a "|" up or down. replace by "+"
  for (var i = 0; i < regionCopyForVerticalEdges.length; i++) {
    for (var j = 0; j < regionCopyForVerticalEdges[i].length; j++) {
      if (regionCopyForVerticalEdges[i][j] == "|") {
        if (regionCopyForVerticalEdges[i][j - 1] == "-") {
          regionCopyForVerticalEdges[i][j] = "+";
        } else if (regionCopyForVerticalEdges[i][j + 1] == "-") {
          regionCopyForVerticalEdges[i][j] = "+";
        }
      } else if (regionCopyForVerticalEdges[i][j] == "-") {
        if (regionCopyForVerticalEdges[i - 1][j] == "|") {
          regionCopyForVerticalEdges[i][j] = "+";
        } else if (regionCopyForVerticalEdges[i + 1][j] == "|") {
          regionCopyForVerticalEdges[i][j] = "+";
        }
      }
    }
  }

  // Step 4: count the number of vertical edges
  bool isEdge = false;
  for (var i = 0; i < regionCopyForVerticalEdges[0].length; i++) {
    for (var j = 0; j < regionCopyForVerticalEdges.length; j++) {
      if (regionCopyForVerticalEdges[j][i] == "|") {
        if (!isEdge) {
          isEdge = true;
          verticalEdges++;
        }
      } else {
        isEdge = false;
      }
    }
  }

  // Step 5: count the number of horizontal edges
  isEdge = false;
  for (var i = 0; i < regionCopyForVerticalEdges.length; i++) {
    for (var j = 0; j < regionCopyForVerticalEdges[i].length; j++) {
      if (regionCopyForVerticalEdges[i][j] == "-") {
        if (!isEdge) {
          isEdge = true;
          horizontalEdges++;
        }
      } else {
        isEdge = false;
      }
    }
  }

  return horizontalEdges + verticalEdges;
}

void findRegion(int y, int x, String regionId, List<List<String>> region) {
  if (visited[y][x] == "#") {
    return;
  }
  if (input[y][x] == regionId) {
    visited[y][x] = "#";
    region[y][x] = regionId;
    findRegion(y - 1, x, regionId, region);
    findRegion(y + 1, x, regionId, region);
    findRegion(y, x - 1, regionId, region);
    findRegion(y, x + 1, regionId, region);
  }
}

List<List<String>> surroundWithHashTags(List<List<String>> matrix) {
  final rows = matrix.length;
  final cols = matrix[0].length;

  // Create a new matrix with extra rows and columns
  final newMatrix = List.generate(rows + 2, (_) => List.filled(cols + 2, "."));

  // Copy the original matrix into the new matrix, offsetting by 1
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      newMatrix[i + 1][j + 1] = matrix[i][j];
    }
  }

  return newMatrix;
}