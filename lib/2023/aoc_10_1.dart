int steps = 0;
int prevRowLocation = -1, prevColumnLocation = -1;
int rowLocation = 0, columnLocation = 0;
List<String> maze = [];

int getSolution(List<String> file) {
  maze = file;
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
  steps++;
  while (maze[rowLocation][columnLocation] != "S") {
    takeStep();
    steps++;
  }
  return (steps / 2).floor();
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
