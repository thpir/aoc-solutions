int getSolution(List<String> file) {
  List<String> input = file[0].split('');
  List<String> inputById = [];
  for (var i = 0; i < input.length; i++) {
    if (i.isEven) {
      for (var j = 0; j < int.parse(input[i]); j++) {
        inputById.add((i ~/ 2).toString());
      }
    } else {
      for (var j = 0; j < int.parse(input[i]); j++) {
        inputById.add(".");
      }
    }
  }
  for (var i = input.length ~/ 2; i >= 0; i--) {
    int fileLocation = inputById.indexOf(i.toString());
    int fileSize = inputById.where((element) => element == i.toString()).length;
    int firstAvailableSpace = hasNConsecutiveDots(inputById, fileSize);
    if (firstAvailableSpace != -1 && firstAvailableSpace < fileLocation) {
      for (var j = 0; j < fileSize; j++) {
        inputById[firstAvailableSpace + j] = i.toString();
        inputById[fileLocation + j] = ".";
      }
    } 
  }
  return getFileSystemChecksum(inputById);
}

int hasNConsecutiveDots(List<String> list, int n) {
  for (var i = 0; i < list.length; i++) {
    if (list[i] == ".") {
      int count = 0;
      for (var j = i; j < list.length; j++) {
        if (list[j] == ".") {
          count++;
        } else {
          break;
        }
      }
      if (count >= n) {
        return i;
      }
    }
  }
  return -1;
}

int returnLastFileBlockElement(List<String> inputById) {
  for (var i = inputById.length - 1; i >= 0; i--) {
    if (inputById[i] != ".") {
      return i;
    }
  }
  return 0;
}

int getFileSystemChecksum(List<String> inputById) {
  int checksum = 0;
  for (var i = 0; i < inputById.length; i++) {
    if (inputById[i] != ".") {
      checksum += int.parse(inputById[i]) * i;
    }
  }
  return checksum;
}