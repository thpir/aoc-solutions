int getSolution(List<String> file) {
  String input = '';
  for (var line in file) {
    input = input+line;
  }
  RegExp regExp = RegExp(r"mul\(\d{1,3},\d{1,3}\)");
  Iterable<Match> matches = regExp.allMatches(input);
  List<String> matchedStrings = matches.map((m) => m.group(0)!).toList();
  List<List<int>> integerPairs = matchedStrings.map((s) {
    RegExp intRegExp = RegExp(r"\d+");
    Iterable<Match> intMatches = intRegExp.allMatches(s);
    return intMatches.map((m) => int.parse(m.group(0)!)).toList();
  }).toList();
  return integerPairs.fold(0, (int acc, List<int> pair) => acc + pair[0] * pair[1]);
}