import 'package:flutter/material.dart';
import 'package:xdrive/widgets/game.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
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
    _winner = Win(this._squares).detect();

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
  final Player player;

  const Square({
    Key key,
    @required this.player,
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
