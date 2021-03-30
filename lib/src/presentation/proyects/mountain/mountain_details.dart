import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/mountain/mountain_model.dart';

class MountainDetails extends StatelessWidget {
  final Mountain mountain;
  const MountainDetails({Key key, this.mountain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
                colors: mountain.colors)),
        child: Stack(children: [
          Stack(children: [
            Positioned(
                top: 40 + MediaQuery.of(context).padding.top,
                left: 25,
                right: 1 * 0.5 + 20,
                child: Text(mountain.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      height: 0.95,
                    )))
          ]),
          Positioned(
            top: 0,
            left: 25,
            right: 25,
            bottom: 30,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 200, bottom: 160),
              child: Column(
                  children: List<Widget>.generate(
                      mountain.information.split('\n').length, (index) {
                String _text = mountain.information.split('\n')[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Text(_text,
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                );
              })),
            ),
          ),
          Positioned(
            right: 0,
            top: 230,
            child: Transform.translate(
              offset: Offset(140, 0),
              child: Container(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(2)),
                child: Hero(
                  tag: 'Button${mountain.name}',
                  child: Material(
                    color: Colors.transparent,
                    child: Row(children: [
                      Text('Information'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.8)),
                      SizedBox(width: 3),
                      Icon(Icons.dangerous, color: Colors.white, size: 11)
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 25,
            child: SafeArea(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.backpack, color: Colors.white, size: 18),
                ),
              ),
            ),
          ),
          Positioned(
            top: 1 * 0.75,
            right: 0,
            left: 0,
            child: Hero(
              tag: 'Mountain${mountain.name}',
              child: Image.asset(''),
            ),
          )
        ]),
      ),
    );
  }
}
