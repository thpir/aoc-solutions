int getSolution(List<String> file) {
  int solution = 0;
  for (String line in file) {
    List<int> numbers = line.split(' ').map((e) => int.parse(e)).toList();
    if (isSafe(numbers)) {
      solution++;
      continue;
    }
    if (isSafeWithBuffer(numbers)) {
      solution++;
    }
  }
  return solution;
}

bool isSafe(List<int> numbers) {
  bool increasing = numbers.first < numbers.last;
  bool isSafe = true;
  for (int i = 0; i < numbers.length - 1; i++) {
    int result = numbers[i + 1] - numbers[i];
    if (increasing && result < 1 || increasing && result > 3) {
      isSafe = false;
    }
    if (!increasing && result > -1 || !increasing && result < -3) {
      isSafe = false;
    }
  }
  return isSafe;
}

bool isSafeWithBuffer(List<int> numbers) {
  for (int i = 0; i < numbers.length; i++) {
    List<int> buffer = List.from(numbers);
    buffer.removeAt(i);
    if (isSafe(buffer)) {
      return true;
    }
  }
  return false;
}
