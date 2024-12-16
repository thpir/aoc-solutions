int getSolution(List<String> file) {
  List<Map<String, dynamic>> clawMachines = parseInput(file);
  int solution = 0;
  for (var clawMachine in clawMachines) {
    //print("Claw machine: $clawMachine");
    int amountOfTokens = findMinimumAmountOfTokens(clawMachine);
    //print("Amount of tokens: $amountOfTokens");
    solution += amountOfTokens;
  }
  return solution;
}

int findMinimumAmountOfTokens(Map<String, dynamic> clawMachine) {
  int xPrice = clawMachine["xPrice"] + 10000000000000;
  int yPrice = clawMachine["yPrice"] + 10000000000000;
  int aX = clawMachine["aX"];
  int aY = clawMachine["aY"];
  int bX = clawMachine["bX"];
  int bY = clawMachine["bY"];

  /* 
    xPrice = aX * A + bX * B 
    yPrice = aY * A + bY * B

    aX * A = xPrice - bX * B
    aY * A = yPrice - bY * B

    aX * bY * B - aY * bX * B  = aX * yPrice - aY * xPrice

    B = (aX * yPrice - aY * xPrice) / (aX * bY - aY * bX)

    A = (xPrice - bX * B) / aX
  */

  double B = (aX * yPrice - aY * xPrice) / (aX * bY - aY * bX);
  double A = (xPrice - bX * B) / aX;

  if (isWholeNumber(A) && isWholeNumber(B)) {
    return A.toInt() * 3 + B.toInt();
  } else {
    return 0;
  }
}

bool isWholeNumber(double number) {
  return number == number.roundToDouble();
}

List<Map<String, dynamic>> parseInput(List<String> file) {
  List<Map<String, dynamic>> input = [];
  for (var i = 0; i < file.length; i += 4) {
    int aX = extractStringValue(file[i], "X+");
    int aY = extractStringValue(file[i], "Y+");
    int bX = extractStringValue(file[i + 1], "X+");
    int bY = extractStringValue(file[i + 1], "Y+");
    int xPrice = extractStringValue(file[i + 2], "X=");
    int yPrice = extractStringValue(file[i + 2], "Y=");
    Map<String, dynamic> map = {
      "aX": aX,
      "aY": aY,
      "bX": bX,
      "bY": bY,
      "xPrice": xPrice,
      "yPrice": yPrice,
    };
    input.add(map);
  }
  return input;
}

int extractStringValue(String input, String key) {
  int startIndex =
      input.indexOf(key) + key.length; // +2 to skip the key characters
  // Find the index of the next comma or end of string
  int endIndex = input.indexOf(",", startIndex);
  if (endIndex == -1) {
    endIndex = input.length;
  }
  String extractedString = input.substring(startIndex, endIndex);
  // Parse the substring to an integer
  return int.parse(extractedString);
}
