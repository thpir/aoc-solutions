int getSolution(List<String> file) {
  List<List<int>> pageOrderingRules = [];
  List<List<int>> pagesToProduce = [];
  List<List<int>> faultyUpdates = [];
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
    if (!fullyCompliant(pageToProduce, pageOrderingRules)) {
      faultyUpdates.add(pageToProduce);
    }
  }

  for (var i = 0; i < faultyUpdates.length; i++) {
    while (!fullyCompliant(faultyUpdates[i], pageOrderingRules)) {
      faultyUpdates[i] = sortUpdate(faultyUpdates[i], pageOrderingRules);
    }
    result += faultyUpdates[i][faultyUpdates[i].length ~/ 2];
  }

  return result;
}

List<int> sortUpdate(
    List<int> faultyUpdate, List<List<int>> pageOrderingRules) {
  for (var rule in pageOrderingRules) {
    print(rule);
    if ((faultyUpdate.contains(rule[0]) && faultyUpdate.contains(rule[1]))) {
      while (!compliant(faultyUpdate, rule)) {
        faultyUpdate.insert(faultyUpdate.indexOf(rule[0]), faultyUpdate.removeAt(faultyUpdate.indexOf(rule[1])));
      }
    }
  }
  return faultyUpdate;
}

bool compliant(List<int> pageToProduce, List<int> rule) {
  if (pageToProduce.indexOf(rule[0]) > pageToProduce.indexOf(rule[1])) {
    return false;
  } else {
    return true;
  }
}

bool fullyCompliant(
    List<int> pageToProduce, List<List<int>> pageOrderingRules) {
  bool compliant = true;
  for (var rule in pageOrderingRules) {
    if (pageToProduce.contains(rule[0]) && pageToProduce.contains(rule[1])) {
      if (pageToProduce.indexOf(rule[0]) > pageToProduce.indexOf(rule[1])) {
        compliant = false;
        break;
      }
    } else {
      continue;
    }
  }
  return compliant;
}
