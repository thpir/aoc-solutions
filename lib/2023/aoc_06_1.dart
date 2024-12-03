int getSolution(List<String> file) {
  var races = processInput(file);
  int result = 1;
  for (Race race in races) {
    result = result * numberOfWins(race);
  }
  return result;
}

int numberOfWins(Race race) {
  int number = 0;
  for (int i = 0; i <= race.time; i++) {
    int attempt = (race.time - i) * i;
    //print(attempt);
    if (race.distance < attempt) {
      number++;
    }
  }
  return number;
}

List<Race> processInput(List<String> file) {
  List<List<int>> modifiedFile = [];
  List<Race> race = [];
  for (String line in file) {
    List<String> lineParts = line.split(':');
    lineParts = lineParts[1].split(' ').map((e) => e.trim()).toList();
    lineParts.removeWhere((element) => element == '');
    modifiedFile.add(lineParts.map((String? str) => int.parse(str!)).toList());
  }
  print(modifiedFile);
  for (int i = 0; i < modifiedFile[0].length; i++) {
    race.add(Race(
      modifiedFile[0][i],
      modifiedFile[1][i],
    ));
  }
  return race;
}

class Race {
  int time;
  int distance;

  Race(this.time, this.distance);
}
