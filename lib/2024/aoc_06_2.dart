enum Direction { up, down, left, right }

int getSolution(List<String> file) {
  int numberOfInfiniteLoops = 0;
  List<List<String>> input = makeGrid(file);
  // Loop over grid,
  for (int i = 0; i < input.length; i++) {
    for (int j = 0; j < input[i].length; j++) {
      input = makeGrid(file);
      // And change each empty space to an obstacle,
      if (input[i][j] == '.') {
        input[i][j] = '#';
        bool guardIsGone = false;
        Map<String, int> guard = locateGuard(input);
        input[guard['y']!][guard['x']!] = ".";
        Direction direction = getDirection(guard, input);
        // Folow the guard until it goes out of bounds or enters an infinite loop,
        while (!guardIsGone) {
          if (obstacleAhead(guard, direction, input)) {
            direction = switchDirection(direction);
          } else {
            if (outOfBounds(guard, direction, input)) {
              guardIsGone = true;
            } else {
              // every time the guard moves, check if it is entering an 
              // infinite loop by checking if the direction mark from the 
              //previous time he was at this location is the same as the current 
              //mark,
              String mark = getDirectionMark(direction);
              if (mark == input[guard['y']!][guard['x']!]) {
                numberOfInfiniteLoops++;
                break;
              } else {
                input[guard['y']!][guard['x']!] = mark;
                guard = moveForward(guard, direction);
              }
            }
          }
        }
      }
    }
  }
  return numberOfInfiniteLoops;
}

String getDirectionMark(Direction direction) {
  String mark = '';
  switch (direction) {
    case Direction.up:
      mark = '^';
      break;
    case Direction.down:
      mark = 'v';
      break;
    case Direction.left:
      mark = '<';
      break;
    case Direction.right:
      mark = '>';
      break;
  }
  return mark;
}

Map<String, int> moveForward(Map<String, int> guard, Direction direction) {
  switch (direction) {
    case Direction.up:
      guard['y'] = guard['y']! - 1;
      break;
    case Direction.down:
      guard['y'] = guard['y']! + 1;
      break;
    case Direction.left:
      guard['x'] = guard['x']! - 1;
      break;
    case Direction.right:
      guard['x'] = guard['x']! + 1;
      break;
  }
  return guard;
}

bool outOfBounds(
    Map<String, int> guard, Direction direction, List<List<String>> grid) {
  bool result = false;
  switch (direction) {
    case Direction.up:
      if (guard['y']! - 1 < 0) {
        result = true;
      }
      break;
    case Direction.down:
      if (guard['y']! + 1 >= grid.length) {
        result = true;
      }
      break;
    case Direction.left:
      if (guard['x']! - 1 < 0) {
        result = true;
      }
      break;
    case Direction.right:
      if (guard['x']! + 1 >= grid[0].length) {
        result = true;
      }
      break;
  }
  return result;
}

Direction switchDirection(Direction direction) {
  Direction newDirection = Direction.up;
  switch (direction) {
    case Direction.up:
      newDirection = Direction.right;
      break;
    case Direction.down:
      newDirection = Direction.left;
      break;
    case Direction.left:
      newDirection = Direction.up;
      break;
    case Direction.right:
      newDirection = Direction.down;
      break;
  }
  return newDirection;
}

bool obstacleAhead(
    Map<String, int> guard, Direction direction, List<List<String>> grid) {
  bool result = false;
  switch (direction) {
    case Direction.up:
      if (guard['y']! - 1 >= 0) {
        if (grid[guard['y']! - 1][guard['x']!] == '#') {
          result = true;
        }
      }
      break;
    case Direction.down:
      if (guard['y']! + 1 < grid.length) {
        if (grid[guard['y']! + 1][guard['x']!] == '#') {
          result = true;
        }
      }
      break;
    case Direction.left:
      if (guard['x']! - 1 >= 0) {
        if (grid[guard['y']!][guard['x']! - 1] == '#') {
          result = true;
        }
      }
      break;
    case Direction.right:
      if (guard['x']! + 1 < grid[0].length) {
        if (grid[guard['y']!][guard['x']! + 1] == '#') {
          result = true;
        }
      }
      break;
  }
  return result;
}

Direction getDirection(Map<String, int> guard, List<List<String>> grid) {
  Direction direction = Direction.up;
  if (grid[guard['y']!][guard['x']!] == '^') {
    direction = Direction.up;
  } else if (grid[guard['y']!][guard['x']!] == 'v') {
    direction = Direction.down;
  } else if (grid[guard['y']!][guard['x']!] == '<') {
    direction = Direction.left;
  } else if (grid[guard['y']!][guard['x']!] == '>') {
    direction = Direction.right;
  }
  return direction;
}

Map<String, int> locateGuard(List<List<String>> grid) {
  Map<String, int> guard = {'x': 0, 'y': 0};
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (grid[i][j] != '.' && grid[i][j] != '#') {
        guard['x'] = j;
        guard['y'] = i;
        return guard;
      }
    }
  }
  return guard;
}

List<List<String>> makeGrid(List<String> file) {
  List<List<String>> grid = [];
  for (String line in file) {
    grid.add(line.split(''));
  }
  return grid;
}