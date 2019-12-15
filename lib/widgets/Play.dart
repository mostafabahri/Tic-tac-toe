import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

enum Player { X, O }

abstract class WinInterface {
  Player detect();
}

class Win implements WinInterface {
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

  @override
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

class _PlayState extends State<Play> {
  var _squares = List<Player>.generate(9, (i) => null);
  var _xNext = true;
  var _winner;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tic Tac Toe', style: Theme.of(context).textTheme.display1),
              SizedBox(height: 20),
              Column(
                children: List<Widget>.generate(3, (i) => _buildRow(i)),
              ),
              RaisedButton(
                color: Colors.blue[300],
                child: Text('reset'),
                onPressed: _resetGame,
              ),
            ]),
      ),
    );
  }

  Row _buildRow(int rowNum) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        3,
        (i) {
          var index = rowNum * 3 + i;
          return GestureDetector(
            onTap: () => _handleTap(index),
            child: Square(
              index: index,
              player: _squares[index],
            ),
          );
        },
      ),
    );
  }

  _handleTap(int index) {
    if (_squares[index] != null || _winner != null) {
      return;
    }
    setState(() {
      _squares[index] = _xNext ? Player.X : Player.O;
      _xNext = !_xNext;
    });
    _announceWinner();
  }

  void _announceWinner() {
    WinInterface win = Win(this._squares);
    _winner = win.detect();

    if (_winner != null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(' $_winner has won!')),
      );
    }
  }

  _resetGame() {
    setState(() {
      _squares = List<Player>.generate(9, (i) => null);
      _xNext = true;
      _winner = null;
    });
  }
}

class Square extends StatelessWidget {
  final int index;
  final Player player;

  const Square({
    Key key,
    @required this.player,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _decoration = BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(color: Colors.black38, blurRadius: 4, offset: Offset(2, 2))
    ]);
    double _size = 100;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: _decoration,
        width: _size,
        height: _size,
        child: _buildPlayer(),
      ),
    );
  }

  Center _buildPlayer() {
    if (player != null) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            player == Player.X ? 'X' : 'O',
            style: TextStyle(fontSize: 35),
          ),
        ],
      ));
    }
    return null;
  }
}
