late List<int> seedMap;
late List<List<int>> seedToSoilMap;
late List<List<int>> soilToFertilizerMap;
late List<List<int>> fertilizerToWaterMap;
late List<List<int>> waterToLightMap;
late List<List<int>> lightToTemperatureMap;
late List<List<int>> temperatureToHumidityMap;
late List<List<int>> humidityToLocationMap;
List<Seed> seedManual = [];

int getSolution(List<String> file) {
  seedMap = getSeedList(file);
  seedToSoilMap = getSeedToSoilMap(file);
  soilToFertilizerMap = getSoilToFertilizerMap(file);
  fertilizerToWaterMap = getFertilizerToWaterMap(file);
  waterToLightMap = getWaterToLightMap(file);
  lightToTemperatureMap = getLightToTemperatureMap(file);
  temperatureToHumidityMap = getTemperatureToHumidityMap(file);
  humidityToLocationMap = getHumidityToLocationMap(file);
  for (int seed in seedMap) {
    seedManual.add(Seed(seed, null, null, null, null, null, null, null));
  }
  print('input processed...');
  addSoil();
  addFertilizer();
  addwater();
  addLight();
  addTemperature();
  addHumidity();
  addLocation();
  return findClosedLocation();
}

addSoil() {
  for (Seed seed in seedManual) {
    for (List<int> row in seedToSoilMap) {
      if (seed.id! >= row[1] && seed.id! < row[1] + row[2]) {
        seed.soil = row[0] + seed.id! - row[1];
      }
    }
    seed.soil ??= seed.id;
  }
}

addFertilizer() {
  for (Seed seed in seedManual) {
    for (List<int> row in soilToFertilizerMap) {
      if (seed.soil! >= row[1] && seed.soil! < row[1] + row[2]) {
        seed.fertilizer = row[0] + seed.soil! - row[1];
      }
    }
    seed.fertilizer ??= seed.soil;
  }
}

addwater() {
  for (Seed seed in seedManual) {
    for (List<int> row in fertilizerToWaterMap) {
      if (seed.fertilizer! >= row[1] && seed.fertilizer! < row[1] + row[2]) {
        seed.water = row[0] + seed.fertilizer! - row[1];
      }
    }
    seed.water ??= seed.fertilizer;
  }
}

addLight() {
  for (Seed seed in seedManual) {
    for (List<int> row in waterToLightMap) {
      if (seed.water! >= row[1] && seed.water! < row[1] + row[2]) {
        seed.light = row[0] + seed.water! - row[1];
      }
    }
    seed.light ??= seed.water;
  }
}

addTemperature() {
  for (Seed seed in seedManual) {
    for (List<int> row in lightToTemperatureMap) {
      if (seed.light! >= row[1] && seed.light! < row[1] + row[2]) {
        seed.temperature = row[0] + seed.light! - row[1];
      }
    }
    seed.temperature ??= seed.light;
  }
}

addHumidity() {
  for (Seed seed in seedManual) {
    for (List<int> row in temperatureToHumidityMap) {
      if (seed.temperature! >= row[1] && seed.temperature! < row[1] + row[2]) {
        seed.humidity = row[0] + seed.temperature! - row[1];
      }
    }
    seed.humidity ??= seed.temperature;
  }
}

addLocation() {
  for (Seed seed in seedManual) {
    for (List<int> row in humidityToLocationMap) {
      if (seed.humidity! >= row[1] && seed.humidity! < row[1] + row[2]) {
        seed.location = row[0] + seed.humidity! - row[1];
      }
    }
    seed.location ??= seed.humidity;
  }
}

int findClosedLocation() {
  int result = 0;
  for (int i = 0; i < seedMap.length; i++) {
    if (i == 0) {
      for (Seed seed in seedManual) {
        if (seed.id == seedMap[i]) {
          if (seed.location != null) {
            result = seed.location!;
          }
        }
      }
    } else {
      for (Seed seed in seedManual) {
        if (seed.id == seedMap[i] && seed.location != null) {
          if (seed.location! < result) {
            result = seed.location!;
          }
        }
      }
    }
  }
  return result;
}

class Seed {
  int? id;
  int? soil;
  int? fertilizer;
  int? water;
  int? light;
  int? temperature;
  int? humidity;
  int? location;

  Seed(this.id, this.soil, this.fertilizer, this.water, this.light,
      this.temperature, this.humidity, this.location);
}

List<int> getSeedList(List<String> file) {
  List<String> seeds = file[0].split('seeds: ');
  List<int> seedList =
      seeds[1].split(' ').map((e) => int.parse(e.trim())).toList();
  //print(seedList);
  return seedList;
}

List<List<int>> getSeedToSoilMap(List<String> file) {
  var isMapping = false;
  List<List<int>> seedToSoilList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      seedToSoilList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('seed-to-soil map:')) {
      isMapping = true;
    }
  }
  //print(seedToSoilList);
  return seedToSoilList;
}

List<List<int>> getSoilToFertilizerMap(List<String> file) {
  var isMapping = false;
  List<List<int>> soilToFertilizerList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      soilToFertilizerList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('soil-to-fertilizer map:')) {
      isMapping = true;
    }
  }
  //print(soilToFertilizerList);
  return soilToFertilizerList;
}

List<List<int>> getFertilizerToWaterMap(List<String> file) {
  var isMapping = false;
  List<List<int>> fertilizerToWaterList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      fertilizerToWaterList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('fertilizer-to-water map:')) {
      isMapping = true;
    }
  }
  //print(fertilizerToWaterList);
  return fertilizerToWaterList;
}

List<List<int>> getWaterToLightMap(List<String> file) {
  var isMapping = false;
  List<List<int>> waterToLightList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      waterToLightList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('water-to-light map:')) {
      isMapping = true;
    }
  }
  //print(waterToLightList);
  return waterToLightList;
}

List<List<int>> getLightToTemperatureMap(List<String> file) {
  var isMapping = false;
  List<List<int>> lightToTemperatureList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      lightToTemperatureList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('light-to-temperature map:')) {
      isMapping = true;
    }
  }
  //print(lightToTemperatureList);
  return lightToTemperatureList;
}

List<List<int>> getTemperatureToHumidityMap(List<String> file) {
  var isMapping = false;
  List<List<int>> temperatureToHumidityList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      temperatureToHumidityList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('temperature-to-humidity map:')) {
      isMapping = true;
    }
  }
  //print(temperatureToHumidityList);
  return temperatureToHumidityList;
}

List<List<int>> getHumidityToLocationMap(List<String> file) {
  var isMapping = false;
  List<List<int>> humidityToLocationList = [];
  for (String line in file) {
    if (line.isEmpty) {
      isMapping = false;
    }
    if (isMapping) {
      // add line to list
      humidityToLocationList
          .add(line.split(' ').map((e) => int.parse(e.trim())).toList());
    }
    if (line.contains('humidity-to-location map:')) {
      isMapping = true;
    }
  }
  //print(humidityToLocationList);
  return humidityToLocationList;
}
