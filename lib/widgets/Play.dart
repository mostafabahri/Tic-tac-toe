import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  var blue = Square(color: Colors.blue);
  var red = Square(color: Colors.red);
  var green = Square(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text('Tic Tac Toe',
                  style: Theme.of(context).textTheme.display1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[green, blue, red],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[blue, red, blue],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[red, blue, green],
            ),
            RaisedButton(
              child: Text('new game'),
              onPressed: () => print('start new game...'),
            )
          ],
        ),
      ),
    );
  }
}

// increment() {
//   var counter = 0;
//   return () => ++counter;
// }

// var inc = increment();

class Square extends StatelessWidget {
  final double size;
  final Color color;

  const Square({Key key, this.color = Colors.red, this.size = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('next move'))),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(color: Colors.white,
                // border: Border.all(color: Colors.black, width: 3)
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(2, 2))
                ]),
            width: size,
            height: size,
            child: Text('')),
      ),
    );
  }
}
