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
  int firstEmptySpace = 0;
  int lastFileBlockElement = inputById.length - 1;
  while (firstEmptySpace < lastFileBlockElement) {
    firstEmptySpace = inputById.indexOf(".");
    lastFileBlockElement = returnLastFileBlockElement(inputById);
    if (firstEmptySpace < lastFileBlockElement) {
      inputById[firstEmptySpace] = inputById[lastFileBlockElement];
      inputById[lastFileBlockElement] = ".";
    }
  }
  return getFileSystemChecksum(inputById);
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