int prevRowLocation = -1, prevColumnLocation = -1;
int rowLocation = 0, columnLocation = 0;
List<List<String>> maze = [];

int getSolution(List<String> file) {
  maze = file.map((e) => e.split("")).toList();
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[i][j] == "S") {
        rowLocation = i;
        columnLocation = j;
        break;
      }
    }
  }
  takeFirstStep();
  while (maze[rowLocation][columnLocation] != "S") {
    takeStep();
  }
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[i][j] == "S") {
        maze[i][j] = "#";
        break;
      }
    }
  }
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[i][j] != "#") {
        maze[i][j] = "O";
      } else {
        break;
      }
    }
  }
  for (int i = 0; i < maze.length; i++) {
    for (int j = maze[i].length - 1; j >= 0; j--) {
      if (maze[i][j] != "#") {
        maze[i][j] = "O";
      } else {
        break;
      }
    }
  }
  for (int i = 0; i < maze[0].length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[j][i] != "#") {
        maze[j][i] = "O";
      } else {
        break;
      }
    }
  }
  for (int i = 0; i < maze[0].length; i++) {
    for (int j = maze[i].length - 1; j >= 0 ; j--) {
      if (maze[j][i] != "#") {
        maze[j][i] = "O";
      } else {
        break;
      }
    }
  }
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (hasNeighboringO(i, j)) {
        maze[j][i] = "O";
      } 
    }
  }
  print(maze);
  int count = 0;
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[i][j] != "O" && maze[i][j] != "#" && maze[i][j] != "S") {
        count++;
      }
    }
  }
  return count;
}

bool hasNeighboringO(int row, int col) {
  // Define relative positions of neighbors (8 possible directions)
  List<List<int>> directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],           [0, 1],
    [1, -1], [1, 0], [1, 1],
  ];

  // Iterate through neighbors
  for (var dir in directions) {
    int newRow = row + dir[0];
    int newCol = col + dir[1];

    // Check if the new position is within bounds
    if (newRow >= 0 && newRow < maze.length &&
        newCol >= 0 && newCol < maze[newRow].length) {
      // Check if the neighboring character is "O"
      if (maze[newRow][newCol] == "O") {
        return true;
      }
    }
  }

  // No "O" found in neighbors
  return false;
}

takeFirstStep() {
  if (rowLocation >= 1) {
    // look up
    if ("|7F".contains(maze[rowLocation - 1][columnLocation]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            ((rowLocation - 1).toString() + columnLocation.toString())) {
      moveUp();
      return;
    }
  }
  if (rowLocation < maze.length - 1) {
    // look down
    if ("|LJ".contains(maze[rowLocation + 1][columnLocation]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            ((rowLocation + 1).toString() + columnLocation.toString())) {
      moveDown();
      return;
    }
  }
  if (columnLocation >= 1) {
    // look left
    if ("-LF".contains(maze[rowLocation][columnLocation - 1]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            (rowLocation.toString() + (columnLocation - 1).toString())) {
      moveLeft();
      return;
    }
  }
  if (columnLocation < maze[rowLocation].length - 1) {
    // look right
    if ("-J7".contains(maze[rowLocation][columnLocation + 1]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            (rowLocation.toString() + (columnLocation + 1).toString())) {
      moveRight();
      return;
    }
  }
}

takeStep() {
  if (rowLocation >= 1) {
    // look up
    if ("|7FS".contains(maze[rowLocation - 1][columnLocation]) &&
        "|LJ".contains(maze[rowLocation][columnLocation]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            ((rowLocation - 1).toString() + columnLocation.toString())) {
      moveUp();
      maze[prevRowLocation][prevColumnLocation] = "#";
      return;
    }
  }
  if (rowLocation < maze.length - 1) {
    // look down
    if ("|LJS".contains(maze[rowLocation + 1][columnLocation]) &&
        "|7F".contains(maze[rowLocation][columnLocation]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            ((rowLocation + 1).toString() + columnLocation.toString())) {
      moveDown();
      maze[prevRowLocation][prevColumnLocation] = "#";
      return;
    }
  }
  if (columnLocation >= 1) {
    // look left
    if ("-LFS".contains(maze[rowLocation][columnLocation - 1]) &&
        "-J7".contains(maze[rowLocation][columnLocation]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            (rowLocation.toString() + (columnLocation - 1).toString())) {
      moveLeft();
      maze[prevRowLocation][prevColumnLocation] = "#";
      return;
    }
  }
  if (columnLocation < maze[rowLocation].length - 1) {
    // look right
    if ("-J7S".contains(maze[rowLocation][columnLocation + 1]) &&
        "-LF".contains(maze[rowLocation][columnLocation]) &&
        (prevRowLocation.toString() + prevColumnLocation.toString()) !=
            (rowLocation.toString() + (columnLocation + 1).toString())) {
      moveRight();
      maze[prevRowLocation][prevColumnLocation] = "#";
      return;
    }
  }
}

moveUp() {
  prevRowLocation = rowLocation;
  prevColumnLocation = columnLocation;
  rowLocation = rowLocation - 1;
}

moveDown() {
  prevRowLocation = rowLocation;
  prevColumnLocation = columnLocation;
  rowLocation = rowLocation + 1;
}

moveLeft() {
  prevRowLocation = rowLocation;
  prevColumnLocation = columnLocation;
  columnLocation = columnLocation - 1;
}

moveRight() {
  prevRowLocation = rowLocation;
  prevColumnLocation = columnLocation;
  columnLocation = columnLocation + 1;
}
