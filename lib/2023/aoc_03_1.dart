List<Gear> gearRatios = [];

int getSolution(List<String> file) {
  int sum = 0;
  // Iterate through lines
  for (var i = 0; i < file.length; i++) {
    var line = file[i];
    // Iterate through chars in line
    int numberOfIterationsToSkip = 0;
    for (var j = 0; j < line.length; j++) {
      if (numberOfIterationsToSkip > 0) {
        numberOfIterationsToSkip--;
        continue;
      }
      // If we find a digit
      if (isDigit(line, j)) {
        String number = line[j];
        int numberLength = 1;
        bool stillNumber = true;
        // Keep adding "1" to numberLength until the char isn't a digit anymore
        while ((j + numberLength) < line.length && stillNumber) {
          // If digit add digit to number and add "1" to numberLength
          if (isDigit(line[j + numberLength], 0)) {
            number += line[j + numberLength];
            numberLength++;
          } else {
            // not a number anymore so check chars around the number and update j
            numberOfIterationsToSkip = numberLength;
            stillNumber = false;
          }
          if ((j + numberLength) == line.length) {
            numberOfIterationsToSkip = numberLength;
            stillNumber = false;
          }
        }
        if (checkPartNumber(i, j, file, numberLength)) {
          sum += int.parse(number);
        }
      }
    }
  }
  return sum;
}

bool isDigit(String line, int j) => (line.codeUnitAt(j) ^ 0x30) <= 9;

bool checkPartNumber(int i, int j, List<String> input, int numberLength) {
  final regExp = RegExp(r'[*+&=$@/\-%#]');
  // Check the line above the part number
  if (i > 0) {
    if (j > 0) {
      if (input[i - 1][j - 1].contains(regExp)) {
        return true;
      }
    }
    if (j + numberLength < input[i - 1].length) {
      //CHECK
      if (input[i - 1][j + numberLength].contains(regExp)) {
        return true;
      }
    }
    for (int k = j; k < j + numberLength; k++) {
      if (input[i - 1][k].contains(regExp)) {
        return true;
      }
    }
  }
  // Check the leading and trailing char around the part number
  if (j > 0) {
    if (input[i][j - 1].contains(regExp)) {
      return true;
    }
  }
  if (j + numberLength < input[i].length) {
    if (input[i][j + numberLength].contains(regExp)) {
      return true;
    }
  }
  // Check the line under the part number
  if (i + 1 < input.length) {
    if (j > 0) {
      if (input[i + 1][j - 1].contains(regExp)) {
        return true;
      }
    }
    if (j + numberLength < input[i + 1].length) {
      if (input[i + 1][j + numberLength].contains(regExp)) {
        return true;
      }
    }
    for (int k = j; k < j + numberLength; k++) {
      if (input[i + 1][k].contains(regExp)) {
        return true;
      }
    }
  }
  return false;
}

checkGearNumber(
    int i, int j, List<String> input, int numberLength, int number) {
  final regExp = RegExp(r'[*]');
  // Check the line above the part number
  if (i > 0) {
    if (j > 0) {
      if (input[i - 1][j - 1].contains(regExp)) {
        if (!checkIfRegistered(i - 1, j - 1, number)) {
          gearRatios.add(Gear(i - 1, j - 1, [number]));
        }
      }
    }
    if (j + numberLength < input[i - 1].length) {
      if (input[i - 1][j + numberLength].contains(regExp)) {
        if (!checkIfRegistered(i - 1, j + numberLength, number)) {
          gearRatios.add(Gear(i - 1, j + numberLength, [number]));
        }
      }
    }
    for (int k = j; k < j + numberLength; k++) {
      if (input[i - 1][k].contains(regExp)) {
        if (!checkIfRegistered(i - 1, k, number)) {
          gearRatios.add(Gear(i - 1, k, [number]));
        }
      }
    }
  }
  // Check the leading and trailing char around the part number
  if (j > 0) {
    if (input[i][j - 1].contains(regExp)) {
      if (!checkIfRegistered(i, j - 1, number)) {
        gearRatios.add(Gear(i, j - 1, [number]));
      }
    }
  }
  if (j + numberLength < input[i].length) {
    if (input[i][j + numberLength].contains(regExp)) {
      if (!checkIfRegistered(i, j + numberLength, number)) {
        gearRatios.add(Gear(i, j + numberLength, [number]));
      }
    }
  }
  // Check the line under the part number
  if (i + 1 < input.length) {
    if (j > 0) {
      if (input[i + 1][j - 1].contains(regExp)) {
        if (!checkIfRegistered(i + 1, j - 1, number)) {
          gearRatios.add(Gear(i + 1, j - 1, [number]));
        }
      }
    }
    if (j + numberLength < input[i + 1].length) {
      if (input[i + 1][j + numberLength].contains(regExp)) {
        if (!checkIfRegistered(i + 1, j + numberLength, number)) {
          gearRatios.add(Gear(i + 1, j + numberLength, [number]));
        }
      }
    }
    for (int k = j; k < j + numberLength; k++) {
      if (input[i + 1][k].contains(regExp)) {
        if (!checkIfRegistered(i + 1, k, number)) {
          gearRatios.add(Gear(i + 1, k, [number]));
        }
      }
    }
  }
}

checkIfRegistered(int x, int y, int ratio) {
  for (Gear gear in gearRatios) {
    if (gear.x == x && gear.y == y) {
      gear.ratios.add(ratio);
      return true;
    }
  }
  return false;
}

class Gear {
  int x;
  int y;
  List<int> ratios;

  Gear(this.x, this.y, this.ratios);
}
