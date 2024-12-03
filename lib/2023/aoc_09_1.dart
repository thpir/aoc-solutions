int getSolution(List<String> file) {
  int solution = 0;
  List<List<int>> input = file
      .map((line) => line.split(' ').map((s) => int.parse(s)).toList())
      .toList();
  for (List<int> line in input) {
    List<List<int>> output = [];
    int history = 0;
    output.add(line);
    while (!output.last.every((element) => element == 0)) {
      output.add([
        for (int i = 0; i < output.last.length - 1; i++)
          output.last[i + 1] - output.last[i]
      ]);
    }
    for (int j = output.length - 1; j > 0; j--) {
      history = output[j - 1].last + history;
    }
    solution += history;
  }
  return solution;
}