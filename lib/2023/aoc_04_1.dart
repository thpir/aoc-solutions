int getSolution(List<String> file) {
  List<ScratchCard> scratchCards = parseInput(file);
  int score = 0;
  for (ScratchCard scratchCard in scratchCards) {
    int thisCardPoints = 0;
    for (int winningNumber in scratchCard.winningNumbers) {
      for (int myNumber in scratchCard.myNumbers) {
        if (winningNumber == myNumber) {
          if (thisCardPoints == 0) {
            thisCardPoints = 1;
          } else {
            thisCardPoints *= 2;
          }
        }
      }
    }
    score += thisCardPoints;
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
