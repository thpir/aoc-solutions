const String key_1 = "XMAS";
const String key_2 = "SAMX";

int getSolution(List<String> file) {
  int result = 0;
  List<List<String>> input = makeGrid(file);
  // diagonal count
  for (int i = 0; i <= input.length - 4; i++) {
    for (int j = 0; j <= input[i].length - 4; j++) {
      if (input[i][j] +
                  input[i + 1][j + 1] +
                  input[i + 2][j + 2] +
                  input[i + 3][j + 3] ==
              key_1 ||
          input[i][j] +
                  input[i + 1][j + 1] +
                  input[i + 2][j + 2] +
                  input[i + 3][j + 3] ==
              key_2) {
        result++;
      }
      if (input[i][j + 3] +
                  input[i + 1][j + 2] +
                  input[i + 2][j + 1] +
                  input[i + 3][j] ==
              key_1 ||
          input[i][j + 3] +
                  input[i + 1][j + 2] +
                  input[i + 2][j + 1] +
                  input[i + 3][j] ==
              key_2) {
        result++;
      }
    }
  }
  // horizontal count
  for (int i = 0; i <= input.length - 1; i++) {
    for (int j = 0; j <= input[i].length - 4; j++) {
      if (input[i][j] + input[i][j + 1] + input[i][j + 2] + input[i][j + 3] ==
              key_1 ||
          input[i][j] + input[i][j + 1] + input[i][j + 2] + input[i][j + 3] ==
              key_2) {
        result++;
      }
    }
  }
  // vertical count
  for (int i = 0; i <= input.length - 4; i++) {
    for (int j = 0; j <= input[i].length - 1; j++) {
      if (input[i][j] + input[i + 1][j] + input[i + 2][j] + input[i + 3][j] ==
              key_1 ||
          input[i][j] + input[i + 1][j] + input[i + 2][j] + input[i + 3][j] ==
              key_2) {
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
