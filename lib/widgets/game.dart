enum Player { X, O }

class Win {
  List<Player> squares;
  var winnerPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  Win(this.squares);

  Player detect() {
    for (var position in winnerPositions) {
      var a = position[0];
      var b = position[1];
      var c = position[2];
      if (squares[a] != null &&
          squares[a] == squares[b] &&
          squares[b] == squares[c]) {
        return squares[a];
      }
    }
    // todo: support draw
    return null;
  }
}
