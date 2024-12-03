int getSolution(List<String> file) {
  List<ScratchCard> scratchCards = parseInput(file);
  List<ScratchCardInstance> scratchCardInstances =
      scratchCards.map((cards) => ScratchCardInstance(cards, 0, 1)).toList();
  int score = 0;
  // Count amount of maching numbers for each scratchcard
  for (int i = 0; i < scratchCardInstances.length; i++) {
    int thisCardPoints = 0;
    for (int winningNumber
        in scratchCardInstances[i].scratchCard.winningNumbers) {
      for (int myNumber in scratchCardInstances[i].scratchCard.myNumbers) {
        if (winningNumber == myNumber) {
          thisCardPoints++;
        }
      }
    }
    scratchCardInstances[i].matchingNumbers = thisCardPoints;
  }
  // Generate instances for each win
  for (int i = 0; i < scratchCardInstances.length; i++) {
    for (int j = 0; j < scratchCardInstances[i].instances; j++) {
      for (int k = 1; k <= scratchCardInstances[i].matchingNumbers; k++) {
        scratchCardInstances[i + k].instances++;
      }
    }
  }
  // Calculate the amount of scratchCards
  for (ScratchCardInstance scratchCardInstance in scratchCardInstances) {
    score += scratchCardInstance.instances;
  }
  return score;
}

List<ScratchCard> parseInput(List<String> file) {
  List<ScratchCard> parsedInput = [];
  for (String line in file) {
    ScratchCard card = ScratchCard([], []);
    List<String> scratchCardNoTitle = line.split(':');
    List<String> scratchCardParts = scratchCardNoTitle[1].split('|');
    List<String> winningPart =
        scratchCardParts[0].split(' ').map((e) => e.trim()).toList();
    List<String> myPart =
        scratchCardParts[1].split(' ').map((e) => e.trim()).toList();
    for (int i = 0; i < winningPart.length; i++) {
      if (winningPart[i].isNotEmpty) {
        card.winningNumbers.add(int.parse(winningPart[i]));
      }
    }
    for (int i = 0; i < myPart.length; i++) {
      if (myPart[i].isNotEmpty) {
        card.myNumbers.add(int.parse(myPart[i]));
      }
    }
    parsedInput.add(card);
  }
  return parsedInput;
}

class ScratchCard {
  List<int> winningNumbers;
  List<int> myNumbers;

  ScratchCard(this.winningNumbers, this.myNumbers);
}

class ScratchCardInstance {
  ScratchCard scratchCard;
  int matchingNumbers;
  int instances;

  ScratchCardInstance(this.scratchCard, this.matchingNumbers, this.instances);
}
