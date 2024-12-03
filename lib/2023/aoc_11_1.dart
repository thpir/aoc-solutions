int getSolution(List<String> file) {
  List<List<String>> galaxy = file.map((e) => e.split("")).toList();
  // Create expansion
  for (int i = 0; i < galaxy.length; i++) {
    if (!galaxy[i].contains("#")) {
      galaxy.insert(i, galaxy[i]);
      i++;
    }
  }
  for (int i = 0; i < galaxy[0].length; i++) {
    bool isEmpty = true;
    for (int j = 0; j < galaxy.length; j++) {
      if (galaxy[j][i].contains("#")) {
        isEmpty = false;
      }
    }
    if (isEmpty) {
      for (int k = 0; k < galaxy.length; k++) {
        galaxy[k].insert(i, ".");
      }
      i++;
    }
  }
  // Name galaxies
  var galaxyName = 1;
  for (int i = 0; i < galaxy.length; i++) {
    for (int j = 0; j < galaxy[i].length; j++) {
      if (galaxy[i][j] == "#") {
        galaxy[i][j] = galaxyName.toString();
        galaxyName++;
      }
    }
  }
  var sum = 0;
  var startFrom = 1;
  for (int i = 1; i < galaxyName; i++) {
    for (int j = startFrom; j < galaxyName; j++) {
      if (i != j) {
        int i1 = galaxy.indexWhere((row) => row.contains(i.toString()));
        int j1 =
            galaxy[i1].indexWhere((column) => column.contains(i.toString()));
        int i2 = galaxy.indexWhere((row) => row.contains(j.toString()));
        int j2 =
            galaxy[i2].indexWhere((column) => column.contains(j.toString()));
        sum += calculateDistance(i1, j1, i2, j2);;
      }
    }
    startFrom++;
  }
  return sum;
}

int calculateDistance(int i1, int j1, int i2, int j2) {
  return ((i2 - i1).abs() + (j2 - j1).abs());
}
