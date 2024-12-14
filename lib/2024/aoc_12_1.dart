late List<List<String>> input;
late List<List<String>> visited;

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
      0, (previousValue, element) => previousValue + element.where((e) => e == regionId).length);
  int perimeter = putFenceAroundRegion(region, regionId);
  return area * perimeter;
}

int putFenceAroundRegion(List<List<String>> region, String regionId) {
  int perimeter = 0;
  for (int y = 0; y < region.length; y++) {
    for (int x = 0; x < region[y].length; x++) {
      if (region[y][x] == regionId) {
        if (region[y - 1][x] == ".") {
          perimeter++;
        }
        if (region[y + 1][x] == ".") {
          perimeter++;
        }
        if (region[y][x - 1] == ".") {
          perimeter++;
        }
        if (region[y][x + 1] == ".") {
          perimeter++;
        }
      }
    }
  }
  return perimeter;
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
  final newMatrix = List.generate(rows + 2, (_) => List.filled(cols + 2, "#"));

  // Copy the original matrix into the new matrix, offsetting by 1
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      newMatrix[i + 1][j + 1] = matrix[i][j];
    }
  }

  return newMatrix;
}
