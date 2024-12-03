List<List<GameRound>> parseInput(List<String> input) {
  List<List<GameRound>> games = [];
  for (String line in input) {
    // "Game x:"" wegknippen uit string
    List<String> parts = line.split(':');
    // Game rondes opsplitsen
    List<String> gameRounds = parts[1].split(';').map((e) => e.trim()).toList();
    List<GameRound> game = [];
    for (String gameRound in gameRounds) {
      GameRound round = GameRound(0, 0, 0);
      List<String> coloredCubes =
          gameRound.split(',').map((e) => e.trim()).toList();
      for (String coloredCube in coloredCubes) {
        if (coloredCube.contains('blue')) {
          var number = int.parse(coloredCube.replaceAll(RegExp(r'[^0-9]'), ''));
          round.countsBlue = number;
        }
        if (coloredCube.contains('red')) {
          var number = int.parse(coloredCube.replaceAll(RegExp(r'[^0-9]'), ''));
          round.countsRed = number;
        }
        if (coloredCube.contains('green')) {
          var number = int.parse(coloredCube.replaceAll(RegExp(r'[^0-9]'), ''));
          round.countsGreen = number;
        }
      }
      game.add(round);
    }
    games.add(game);
  }
  return games;
}

int getSolution(List<String> file) {
  List<List<GameRound>> game = parseInput(file);
  int sum = 0;
  int maxRed = 12;
  int maxGreen = 13;
  int maxBlue = 14;
  for (int i = 1; i <= game.length; i++) {
    var possible = true;
    for (GameRound round in game[i - 1]) {
      if (round.countsBlue > maxBlue ||
          round.countsGreen > maxGreen ||
          round.countsRed > maxRed) {
        possible = false;
      }
    }
    if (possible) {
      sum += i;
    }
  }
  return sum;
}

class GameRound {
  int countsBlue;
  int countsRed;
  int countsGreen;

  GameRound(this.countsBlue, this.countsRed, this.countsGreen);
}
