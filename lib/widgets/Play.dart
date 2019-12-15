import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

enum Player { X, O }

class _PlayState extends State<Play> {
  var _squares =
      List<Player>.generate(9, (i) => i.isEven ? Player.X : Player.O);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tic Tac Toe', style: Theme.of(context).textTheme.display1),
            SizedBox(height: 20),
            Column(
              children: List<Widget>.generate(3, (i) => _buildRow(i)),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildRow(int rowNum) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        3,
        (i) => Square(
          index: rowNum * 3 + i,
          player: _squares[rowNum * 3 + i],
        ),
      ),
    );
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
            player == Player.X ? 'X ' : 'O',
            style: TextStyle(fontSize: 35),
          ),
          Text('$index')
        ],
      ));
    }
    return null;
  }
}
