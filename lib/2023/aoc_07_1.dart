List<Hand> procesInput(List<String> file) {
  return file.map((line) {
    var lineparts = line.split(' ');
    return Hand(lineparts[0], int.parse(lineparts[1]));
  }).toList();
}

int getSolution(List<String> file) {
  var hands = procesInput(file);
  return classifyList(hands);
}

int classifyList(List<Hand> hands) {
  List<Hand> highCard = [];
  List<Hand> pair = [];
  List<Hand> twoPairs = [];
  List<Hand> threeOfAKind = [];
  List<Hand> fullHouse = [];
  List<Hand> fourOfAKind = [];
  List<Hand> fiveOfAKind = [];
  for (Hand hand in hands) {
    if (hasFiveOfAKind(hand.hand)) {
      fiveOfAKind.add(hand);
    } else if (hasFourOfAKind(hand.hand)) {
      fourOfAKind.add(hand);
    } else if (hasFullHouse(hand.hand)) {
      fullHouse.add(hand);
    } else if (hasThreeOfAKind(hand.hand)) {
      threeOfAKind.add(hand);
    } else if (hasTwoPairs(hand.hand)) {
      twoPairs.add(hand);
    } else if (hasPair(hand.hand)) {
      pair.add(hand);
    } else {
      highCard.add(hand);
    }
  }
  fiveOfAKind.sort((a, b) => compareStrings(a.hand, b.hand));
  fourOfAKind.sort((a, b) => compareStrings(a.hand, b.hand));
  fullHouse.sort((a, b) => compareStrings(a.hand, b.hand));
  threeOfAKind.sort((a, b) => compareStrings(a.hand, b.hand));
  twoPairs.sort((a, b) => compareStrings(a.hand, b.hand));
  pair.sort((a, b) => compareStrings(a.hand, b.hand));
  highCard.sort((a, b) => compareStrings(a.hand, b.hand));
  List<Hand> sortedHands = highCard +
      pair +
      twoPairs +
      threeOfAKind +
      fullHouse +
      fourOfAKind +
      fiveOfAKind;
  int result = 0;
  for (int i = 1; i <= sortedHands.length; i++) {
    print('Hand: ${sortedHands[i - 1].hand}, bid: ${sortedHands[i - 1].bid}, rank: $i');
    result += sortedHands[i - 1].bid * i;
  }
  return result;
}

int compareStrings(String a, String b) {
  for (int i = 0; i < a.length; i++) {
    int valueA = getValue(a[i]);
    int valueB = getValue(b[i]);

    if (valueA != valueB) {
      return valueA - valueB;
    }
  }

  return 0; // Strings are equal
}

int getValue(String char) {
  if (char == '2') return 0;
  if (char == '3') return 1;
  if (char == '4') return 2;
  if (char == '5') return 3;
  if (char == '6') return 4;
  if (char == '7') return 5;
  if (char == '8') return 6;
  if (char == '9') return 7;
  if (char == 'T') return 8;
  if (char == 'J') return 9;
  if (char == 'Q') return 10;
  if (char == 'K') return 11;
  if (char == 'A') return 12;
  // Add more cases for characters '3' to 'Z' based on their order in ASCII
  return char.codeUnitAt(
      0); // Default to ASCII value if not a numeric or uppercase letter
}

bool hasPair(String hand) {
  Map<String, int> counts = {};
  for (int i = 0; i < hand.length; i++) {
    String card = hand[i].toLowerCase();
    counts[card] = counts.containsKey(card) ? counts[card]! + 1 : 1;
  }
  return counts.values.any((count) => count >= 2);
}

bool hasTwoPairs(String hand) {
  Map<String, int> counts = {};
  for (int i = 0; i < hand.length; i++) {
    String card = hand[i].toLowerCase();
    counts[card] = counts.containsKey(card) ? counts[card]! + 1 : 1;
  }
  // Check for two pairs
  int pairFoundCount = 0;
  for (int count in counts.values) {
    if (count == 2) {
      pairFoundCount++;
      if (pairFoundCount >= 2) {
        return true;
      }
    }
  }
  return false;
}

bool hasThreeOfAKind(String hand) {
  Map<String, int> counts = {};
  for (int i = 0; i < hand.length; i++) {
    String card = hand[i].toLowerCase();
    counts[card] = counts.containsKey(card) ? counts[card]! + 1 : 1;
  }
  return counts.values.any((count) => count >= 3);
}

bool hasFullHouse(String hand) {
  Map<String, int> counts = {};
  for (int i = 0; i < hand.length; i++) {
    String card = hand[i].toLowerCase();
    counts[card] = counts.containsKey(card) ? counts[card]! + 1 : 1;
  }
  return counts.values.any((count) => count == 2) &&
      counts.values.any((count) => count == 3);
}

bool hasFourOfAKind(String hand) {
  Map<String, int> counts = {};
  for (int i = 0; i < hand.length; i++) {
    String card = hand[i].toLowerCase();
    counts[card] = counts.containsKey(card) ? counts[card]! + 1 : 1;
  }
  return counts.values.any((count) => count >= 4);
}

bool hasFiveOfAKind(String hand) {
  Map<String, int> counts = {};
  for (int i = 0; i < hand.length; i++) {
    String card = hand[i].toLowerCase();
    counts[card] = counts.containsKey(card) ? counts[card]! + 1 : 1;
  }
  return counts.values.any((count) => count >= 5);
}

class Hand {
  final String hand;
  final int bid;

  Hand(this.hand, this.bid);
}
