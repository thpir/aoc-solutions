int getSolution(List<String> file) {
  int result = 0;
  for (String line in file) {
    int solution = int.parse(line.split(":")[0]);
    List<int> numbers =
        line.split(":")[1].trim().split(" ").map((e) => int.parse(e)).toList();
    List<String> expressions = generateExpressions(numbers);
    for (String expression in expressions) {
      List<String> list = expression.split(" ");
      int? subResult;
      for (int i = 0; i < list.length; i = i + 2) {
        if (subResult == null) {
          subResult = int.parse(list[i]);
        } else {
          if (list[i - 1] == "+") {
            subResult = subResult + int.parse(list[i]);
          } else if (list[i - 1] == "*") {
            subResult = subResult * int.parse(list[i]);
          } else {
            var mem = subResult.toString() + list[i].toString();
            subResult = int.parse(mem);
          }
        }
      }
      if (subResult == solution) {
        result = result + solution;
        break;
      }
    }
  }
  return result;
}

List<String> generateExpressions(List<int> numbers) {
  if (numbers.length == 1) {
    return [numbers[0].toString()];
  }
  final expressions = <String>[];
  final subExpressions = generateExpressions(numbers.sublist(1));

  for (String subExpression in subExpressions) {
    expressions.add("${numbers[0]} + $subExpression");
    expressions.add("${numbers[0]} * $subExpression");
    expressions.add("${numbers[0]} || $subExpression");
  }
  return expressions;
}

      
      // print(list);

            // 

      // int? subResult;
      // for (int i = 0; i < list.length; i=i+2) {
      //   if (subResult == null) {
      //     subResult = int.parse(list[i]);
      //   } else {
      //     if (list[i - 1] == "+") {
      //       subResult = subResult + int.parse(list[i]);
      //     } else {
      //       subResult = subResult * int.parse(list[i]);
      //     }
      //   }
      // }
      // if (subResult == solution) {
      //   result = result + solution;
      //   break;
      // }