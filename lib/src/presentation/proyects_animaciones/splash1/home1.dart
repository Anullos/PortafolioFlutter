import 'package:flutter/material.dart';

class Home1Screen extends StatelessWidget {
  const Home1Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Probando Hero'),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.home),
              Icon(Icons.ac_unit),
              Hero(
                tag: 'fondo',
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Text('1'),
                  ),
                ),
              ),
              Icon(Icons.home),
              Icon(Icons.ac_unit),
            ],
          ),
        ],
      ),
    );
  }
}
