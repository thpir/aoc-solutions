int getSolution(List<String> file) {
  List<List<int>> pageOrderingRules = [];
  List<List<int>> pagesToProduce = [];
  int result = 0;

  for (var i = 0; i < file.length; i++) {
    if (file[i].contains('|')) {
      pageOrderingRules.add(
          file[i].split('|').map((ruleItem) => int.parse(ruleItem)).toList());
    }
    if (file[i].contains(',')) {
      pagesToProduce.add(
          file[i].split(',').map((ruleItem) => int.parse(ruleItem)).toList());
    }
  }

  for (var pageToProduce in pagesToProduce) {
    if (compliant(pageToProduce, pageOrderingRules)) {
      result += pageToProduce[pageToProduce.length ~/ 2];
    }
  }

  return result;
}

bool compliant(List<int> pageToProduce, List<List<int>> pageOrderingRules) {
  bool compliant = true;
  for (var rule in pageOrderingRules) {
    if (pageToProduce.contains(rule[0]) &&
        pageToProduce.contains(rule[1])) {
      if (pageToProduce.indexOf(rule[0]) >
          pageToProduce.indexOf(rule[1])) {
        compliant = false;
        break;
      }
    } else {
      continue;
    }
  }
  return compliant;
}
