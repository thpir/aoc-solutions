int numberOfBlinks = 75;

int getSolution(List<String> file) {
  List<String> stringInput = file[0].split(' ');
  List<Map<String, int>> input = stringInput
      .map((e) => {'value': int.parse(e), 'amountOfTimes': 1})
      .toList();
  for (var i = 0; i < numberOfBlinks; i++) {
    List<Map<String, int>> newInput = [];
    for (var j = 0; j < input.length; j++) {
      newInput.addAll(stoneAction(input[j]));
    }
    input.clear();
    for (var stone in newInput) {
      if (findMapWithValue(input, stone["value"]!) != -1) {
        int index = findMapWithValue(input, stone["value"]!);
        input[index]['amountOfTimes'] =
            input[index]['amountOfTimes']! + stone["amountOfTimes"]!;
      } else {
        input.add(stone);
      }
    }
  }
  int result = 0;
  for (var stone in input) {
    result += stone['amountOfTimes']!;
  }
  return result;
}

List<Map<String, int>> stoneAction(Map<String, int> stone) {
  List<Map<String, int>> result = [];
  if (stone["value"] == 0) {
    result.add({'value': 1, 'amountOfTimes': stone["amountOfTimes"]!});
  } else if (stone["value"].toString().length.isEven) {
    String stoneString = stone["value"].toString();
    int middleIndex = stoneString.length ~/ 2;
    String firstHalf = stoneString.substring(0, middleIndex);
    String secondHalf = stoneString.substring(middleIndex);
    result.add({
      'value': int.parse(firstHalf),
      'amountOfTimes': stone["amountOfTimes"]!
    });
    result.add({
      'value': int.parse(secondHalf),
      'amountOfTimes': stone["amountOfTimes"]!
    });
  } else {
    result.add({
      'value': stone['value']! * 2024,
      'amountOfTimes': stone["amountOfTimes"]!
    });
  }
  return result;
}

int findMapWithValue(List<Map<String, int>> list, int targetValue) {
  for (int i = 0; i < list.length; i++) {
    if (list[i]['value'] == targetValue) {
      return i;
    }
  }
  return -1;
}
