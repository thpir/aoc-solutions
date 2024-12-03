int getSolution(List<String> file) {
  List<int> listOne = [];
  List<int> listTwo = [];
  int result = 0;
  for (String line in file) {
    var modifiedLine = line.split('   ');
    listOne.add(int.parse(modifiedLine[0]));
    listTwo.add(int.parse(modifiedLine[1]));
  }
  listOne.sort();
  listTwo.sort();
  for (var i = 0; i < listOne.length; i++) {
    result += (listTwo[i] - listOne[i]).abs();
  }
  return result;
}