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
  for (int i = 0; i < game.length; i++) {
    int minRed = 0;
    int minGreen = 0;
    int minBlue = 0;
    for (GameRound round in game[i]) {
      if (round.countsBlue > minBlue) {
        minBlue = round.countsBlue;
      }
      if (round.countsRed > minRed) {
        minRed = round.countsRed;
      }
      if (round.countsGreen > minGreen) {
        minGreen = round.countsGreen;
      }
    }
    sum += minBlue * minRed * minGreen;
  }
  return sum;
}

class GameRound {
  int countsBlue;
  int countsRed;
  int countsGreen;

  GameRound(this.countsBlue, this.countsRed, this.countsGreen);
}
