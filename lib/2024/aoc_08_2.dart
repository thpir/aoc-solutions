int getSolution(List<String> file) {
  List<List<String>> inputGrid = file.map((line) => line.split('').toList()).toList();
  List<List<String>> grid = List.generate(inputGrid.length, (i) => List.filled(inputGrid[i].length, '.'),);
  List<Map<String, dynamic>> antennas = findAntennas(inputGrid);
  for (var antenna in antennas) {
    for (var secondAntenna in antennas) {
      grid[antenna['x']][antenna['y']] = "#";
      if (antenna['x'] == secondAntenna['x'] && antenna['y'] == secondAntenna['y']) {
        continue;
      } else if (antenna['freq'] == secondAntenna['freq']) {
        var deltaX = secondAntenna['x'] - antenna['x'];
        var deltaY = secondAntenna['y'] - antenna['y'];
        var antinodeX = antenna['x'] - deltaX;
        var antinodeY = antenna['y'] - deltaY;
        while (antinodeX >= 0 && antinodeX < inputGrid.length && antinodeY >= 0 && antinodeY < inputGrid[0].length) {
          grid[antinodeX][antinodeY] = '#';
          antinodeX -= deltaX;
          antinodeY -= deltaY;
        }
      } else {
        continue;
      }
    }
  }
  return grid.fold(0, (sum, element) => sum + element.where((element) => element == '#').length);
}

List<Map<String, dynamic>> findAntennas(List<List<String>> inputGrid) {
  List<Map<String, dynamic>> antennas = [];
  for (int i = 0; i < inputGrid.length; i++) {
    for (int j = 0; j < inputGrid[i].length; j++) {
      if (inputGrid[i][j] != ".") {
        Map<String, dynamic> antenna = {
          'x': i,
          'y': j,
          'freq': inputGrid[i][j],
        };
        antennas.add(antenna);
      }
    }
  }
  return antennas;
}