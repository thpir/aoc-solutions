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
  int minimumAmountOfTokens = 0;
  for (var a = 1; a <= 100; a++) {
    for (var b = 1; b <= 100; b++) {
      // check if the claw machine can be solved with i X tokens and j Y tokens
      if (clawMachine["aX"] * a + clawMachine["bX"] * b ==
              clawMachine["xPrice"] &&
          clawMachine["aY"] * a + clawMachine["bY"] * b ==
              clawMachine["yPrice"]) {
        //print("Found solution with $a A tokens and $b B tokens");
        int amountOfTokens = (a * 3) + b;
        if (minimumAmountOfTokens == 0) {
          //print("Setting minimum amount of tokens to $amountOfTokens");
          minimumAmountOfTokens = amountOfTokens;
        }
        if (amountOfTokens < minimumAmountOfTokens) {
          minimumAmountOfTokens = amountOfTokens;
        }
      }
    }
  }
  return minimumAmountOfTokens;
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
