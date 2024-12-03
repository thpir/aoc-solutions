bool isDigit(String char) {
  return RegExp(r'\d').hasMatch(char);
}

int getSolution(List<String> file) {
  return file
      .map((str) => [
            str.split('').firstWhere((char) => isDigit(char), orElse: () => ""),
            str.split('').lastWhere((char) => isDigit(char), orElse: () => ""),
          ].join())
      .toList().fold(0, (sum, number) => sum + int.parse(number));
}