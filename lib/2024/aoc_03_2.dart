// ignore_for_file: non_constant_identifier_names

String DO_PATTERN = "do()";
String DONT_PATTERN = "don't()";

int getSolution(List<String> file) {
  String input = '';
  String filteredInput = '';
  int startOfEnabledCode = 0;
  bool isDisabledCode = false;

  for (var line in file) {
    input = input + line;
  }
  for (var i = 0; i < input.length - DONT_PATTERN.length; i++) {
    if (!isDisabledCode) {
      if (input.substring(i, i + DONT_PATTERN.length) == DONT_PATTERN) {
        print("dont found at $i");
        isDisabledCode = true;
        filteredInput = filteredInput + input.substring(startOfEnabledCode, i);
      }
    } else {
      if (input.substring(i, i + DO_PATTERN.length) == DO_PATTERN) {
        print("do found at $i");
        isDisabledCode = false;
        startOfEnabledCode = i + DO_PATTERN.length;
      }
    }
  }
  filteredInput = filteredInput + input.substring(startOfEnabledCode, input.length);
  print(filteredInput);

  RegExp regExp = RegExp(r"mul\(\d{1,3},\d{1,3}\)");
  Iterable<Match> matches = regExp.allMatches(filteredInput);
  List<String> matchedStrings = matches.map((m) => m.group(0)!).toList();
  List<List<int>> integerPairs = matchedStrings.map((s) {
    RegExp intRegExp = RegExp(r"\d+");
    Iterable<Match> intMatches = intRegExp.allMatches(s);
    return intMatches.map((m) => int.parse(m.group(0)!)).toList();
  }).toList();
  return integerPairs.fold(
      0, (int acc, List<int> pair) => acc + pair[0] * pair[1]);
}
