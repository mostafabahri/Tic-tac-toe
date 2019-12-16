enum Player { X, O }

enum Status { unfinished, draw, win }

class GameStatus {
  final Status status;
  final Player winner;

  const GameStatus({this.status, this.winner})
      : assert(winner == null || status == Status.win);
}

class GameLoop {
  List<Player> squares;
  static var winnerPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  GameLoop(this.squares);

  GameStatus update() {
    for (var position in winnerPositions) {
      var a = position[0];
      var b = position[1];
      var c = position[2];
      if (squares[a] != null &&
          squares[a] == squares[b] &&
          squares[b] == squares[c]) {
        return GameStatus(status: Status.win, winner: squares[a]);
      }
    }
    if (boardFilled()) {
      return GameStatus(status: Status.draw);
    }
    return GameStatus(status: Status.unfinished);
  }

  bool boardFilled() => squares.where((Player x) => x == null).length == 0;
}
