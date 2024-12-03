List<String> convertTextToDigits(List<String> file) {
  List<String> digitList = [];
  for (String line in file) {
    var modifiedLine = '';
    var charList = [];
    line.split('').forEach((ch) => charList.add(ch));
    for (int i = 0; i < charList.length; i++) {
      if (charList[i] == '1') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '2') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '3') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '4') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '5') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '6') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '7') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '8') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == '9') {
        modifiedLine += charList[i];
        continue;
      }
      if (charList[i] == 'o') {
        if (i < charList.length - 2) {
          if (charList[i] + charList[i + 1] + charList[i + 2] == 'one') {
            modifiedLine += '1';
            continue;
          }
        }
      }
      if (charList[i] == 't') {
        if (i < charList.length - 2) {
          if (charList[i] + charList[i + 1] + charList[i + 2] == 'two') {
            modifiedLine += '2';
            continue;
          }
        }
      }
      if (charList[i] == 't') {
        if (i < charList.length - 4) {
          if (charList[i] +
                  charList[i + 1] +
                  charList[i + 2] +
                  charList[i + 3] +
                  charList[i + 4] ==
              'three') {
            modifiedLine += '3';
            continue;
          }
        }
      }
      if (charList[i] == 'f') {
        if (i < charList.length - 3) {
          if (charList[i] +
                  charList[i + 1] +
                  charList[i + 2] +
                  charList[i + 3] ==
              'four') {
            modifiedLine += '4';
            continue;
          }
        }
      }
      if (charList[i] == 'f') {
        if (i < charList.length - 3) {
          if (charList[i] +
                  charList[i + 1] +
                  charList[i + 2] +
                  charList[i + 3] ==
              'five') {
            modifiedLine += '5';
            continue;
          }
        }
      }
      if (charList[i] == 's') {
        if (i < charList.length - 2) {
          if (charList[i] + charList[i + 1] + charList[i + 2] == 'six') {
            modifiedLine += '6';
            continue;
          }
        }
      }
      if (charList[i] == 's') {
        if (i < charList.length - 4) {
          if (charList[i] +
                  charList[i + 1] +
                  charList[i + 2] +
                  charList[i + 3] +
                  charList[i + 4] ==
              'seven') {
            modifiedLine += '7';
            continue;
          }
        }
      }
      if (charList[i] == 'e') {
        if (i < charList.length - 4) {
          if (charList[i] +
                  charList[i + 1] +
                  charList[i + 2] +
                  charList[i + 3] +
                  charList[i + 4] ==
              'eight') {
            modifiedLine += '8';
            continue;
          }
        }
      }
      if (charList[i] == 'n') {
        if (i < charList.length - 3) {
          if (charList[i] +
                  charList[i + 1] +
                  charList[i + 2] +
                  charList[i + 3] ==
              'nine') {
            modifiedLine += '9';
            continue;
          }
        }
      }
    }
    digitList.add(modifiedLine);
  }
  return digitList;
}

List<int> getFirstLastDigit(List<String> file) {
  var digitFile = convertTextToDigits(file);
  List<int> firstLastDigitList = [];
  for (String line in digitFile) {
    if (line != '') {
      String first = line[0];
      String last = line[line.length - 1];
      firstLastDigitList.add(int.parse(first + last));
    }
  }
  return firstLastDigitList;
}

int getSolution(List<String> file) {
  var editedFile = getFirstLastDigit(file);
  int solution = 0;
  for (int number in editedFile) {
    solution += number;
  }
  return solution;
}