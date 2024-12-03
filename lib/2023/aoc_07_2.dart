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
    List<CardType> counts = [];
    int jokers = 0;
    for (int i = 0; i < hand.hand.length; i++) {
      String activeCard = hand.hand[i];
      bool inCounts = false;
      for (CardType card in counts) {
        if (card.card == activeCard) {
          card.amount++;
          inCounts = true;
        }
      }
      if (hand.hand[i] == 'J') {
        jokers++;
      }
      if (!inCounts && hand.hand[i] != 'J') {
        counts.add(CardType(activeCard, 1));
      }
      counts.sort((a, b) => b.amount.compareTo(a.amount));
    }
    /*for (CardType type in counts) {
        print('${type.card} , ${type.amount}');
    }*/
    if (hasFiveOfAKind(counts, jokers)) {
      fiveOfAKind.add(hand);
    } else if (hasFourOfAKind(counts, jokers)) {
      fourOfAKind.add(hand);
    } else if (hasFullHouse(counts, jokers)) {
      fullHouse.add(hand);
    } else if (hasThreeOfAKind(counts, jokers)) {
      threeOfAKind.add(hand);
    } else if (hasTwoPairs(counts, jokers)) {
      twoPairs.add(hand);
    } else if (hasPair(counts, jokers)) {
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
  /*for (int k = 0; k < fullHouse.length; k++) {
    print('Hand: ${fullHouse[k].hand}, bid: ${fullHouse[k].bid}');
  }*/
  for (int j = 1; j <= sortedHands.length; j++) {
    print(
        'Hand: ${sortedHands[j - 1].hand}, bid: ${sortedHands[j - 1].bid}, rank: $j');
    result += sortedHands[j - 1].bid * j;
  }
  return result;
}

int compareStrings(String a, String b) {
  int valueA = 0;
  int valueB = 0;
  for (int i = 0; i < a.length; i++) {
    valueA += getValue(a[i]);
    valueB += getValue(b[i]);

    if (valueA != valueB) {
      return valueA - valueB;
    }
  }

  return 0; // Strings are equal
}

int getValue(String char) {
  if (char == 'J') return 0;
  if (char == '2') return 1;
  if (char == '3') return 2;
  if (char == '4') return 3;
  if (char == '5') return 4;
  if (char == '6') return 5;
  if (char == '7') return 6;
  if (char == '8') return 7;
  if (char == '9') return 8;
  if (char == 'T') return 9;
  if (char == 'Q') return 10;
  if (char == 'K') return 11;
  if (char == 'A') return 12;
  // Add more cases for characters '3' to 'Z' based on their order in ASCII
  return char.codeUnitAt(
      0); // Default to ASCII value if not a numeric or uppercase letter
}

bool hasPair(List<CardType> counts, int jokers) {
  return counts.first.amount + jokers >= 2;
}

bool hasTwoPairs(List<CardType> counts, int jokers) {
  int jokersLeft = jokers;
  int pairOne = counts[0].amount;
  int pairTwo = counts[1].amount;
  for (int i = pairOne; i < 2; i++) {
    if (jokersLeft > 0) {
      pairOne++;
      jokersLeft--;
    }
  }
  for (int j = pairTwo; j < 2; j++) {
    if (jokersLeft > 0) {
      pairTwo++;
      jokersLeft--;
    }
  }
  return pairOne >= 2 && pairTwo >= 2;
}

bool hasThreeOfAKind(List<CardType> counts, int jokers) {
  return counts.first.amount + jokers >= 3;
}

bool hasFullHouse(List<CardType> counts, int jokers) {
  int jokersLeft = jokers;
  int threeOfAKind = counts[0].amount;
  int pair = counts[1].amount;
  for (int i = threeOfAKind; i < 3; i++) {
    if (jokersLeft > 0) {
      threeOfAKind++;
      jokersLeft--;
    }
  }
  for (int j = pair; j < 2; j++) {
    if (jokersLeft > 0) {
      pair++;
      jokersLeft--;
    }
  }
  return threeOfAKind >= 3 && pair >= 2;
}

bool hasFourOfAKind(List<CardType> counts, int jokers) {
  return counts.first.amount + jokers >= 4;
}

bool hasFiveOfAKind(List<CardType> counts, int jokers) {
  if (counts.isNotEmpty) {
    return counts.first.amount + jokers >= 5;
  } else {
    return jokers >= 5;
  }
}

class Hand {
  final String hand;
  final int bid;

  Hand(this.hand, this.bid);
}

class CardType {
  final String card;
  int amount;

  CardType(this.card, this.amount);
}
