int getSolution(List<String> file) {
  List<int> listOne = [];
  List<int> listTwo = [];
  List<int> numOfAppearances = [];
  int result = 0;
  for (String line in file) {
    var modifiedLine = line.split('   ');
    listOne.add(int.parse(modifiedLine[0]));
    listTwo.add(int.parse(modifiedLine[1]));
  }
  for (var i = 0; i < listOne.length; i++) {
    numOfAppearances.add(listTwo.where((number) => number == listOne[i]).length);
    result += listOne[i] * numOfAppearances[i];
  }
  return result;
}
