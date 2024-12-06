const String key_1 = "MAS";
const String key_2 = "SAM";

int getSolution(List<String> file) {
  int result = 0;
  List<List<String>> input = makeGrid(file);
  // diagonal count
  for (int i = 0; i <= input.length - 3; i++) {
    for (int j = 0; j <= input[i].length - 3; j++) {
      if (
          (input[i][j] + input[i + 1][j + 1] + input[i + 2][j + 2] == key_1 ||
          input[i][j] + input[i + 1][j + 1] + input[i + 2][j + 2] == key_2) && 
          (input[i + 2][j] + input[i + 1][j + 1] + input[i][j + 2] == key_1 ||
          input[i + 2][j] + input[i + 1][j + 1] + input[i][j + 2] == key_2)) {
        result++;
      }
    }
  }
  return result;
}

List<List<String>> makeGrid(List<String> file) {
  List<List<String>> grid = [];
  for (String line in file) {
    grid.add(line.split(''));
  }
  return grid;
}
