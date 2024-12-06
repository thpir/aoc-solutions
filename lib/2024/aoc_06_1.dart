// Step 1: locate guard
// Step 2: find out guard's walking direction
// Step 3: find out if obstacle ahead
// Step 4: if yes, change direction and retur to step 3,
//         if no, check for end of grid,
//            if yes, stop iteration,
//            if no, move forward and return to step 3
// Step 5: return result

enum Direction { up, down, left, right }

int getSolution(List<String> file) {
  bool guardIsGone = false;
  List<List<String>> input = makeGrid(file);
  Map<String, int> guard = locateGuard(input);
  Direction direction = getDirection(guard, input);
  while (!guardIsGone) {
    if (obstacleAhead(guard, direction, input)) {
      direction = switchDirection(direction);
    } else {
      if (outOfBounds(guard, direction, input)) {
        input[guard['y']!][guard['x']!] = 'X';
        guardIsGone = true;
      } else {
        input[guard['y']!][guard['x']!] = 'X';
        guard = moveForward(guard, direction);
      }
    }
  }
  return countSteps(input);
}

int countSteps(List<List<String>> grid) {
  int steps = 0;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (grid[i][j] == 'X') {
        steps++;
      }
    }
  }
  return steps;
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

bool outOfBounds(Map<String, int> guard, Direction direction, List<List<String>> grid) {
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

bool obstacleAhead(Map<String, int> guard, Direction direction, List<List<String>> grid) {
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