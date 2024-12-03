int getSolution(List<String> file) {
  return numberOfWins(processInput(file));
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

Race processInput(List<String> file) {
  List<int> raceParts = [];
  for (String line in file) {
    var number = int.parse(line.replaceAll(RegExp(r'[^0-9]'), ''));
    raceParts.add(number);
  }
  return Race(raceParts[0], raceParts[1]);
}

class Race {
  int time;
  int distance;

  Race(this.time, this.distance);
}
