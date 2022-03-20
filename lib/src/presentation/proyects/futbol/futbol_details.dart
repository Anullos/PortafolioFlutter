import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/futbol/futbol_model.dart';

class FutbolDetails extends StatelessWidget {
  final Balon balon;
  const FutbolDetails({Key? key, required this.balon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: BackButton(),
          ),
          Positioned(
            top: 90,
            left: 30,
            child: Hero(
              tag: 'name${balon.color}',
              child: Container(
                width: 150,
                child: Material(
                  child: Text(
                    balon.name,
                    style:
                        TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Hero(
              tag: 'container${balon.color}',
              child: Container(
                height: 400,
                width: 180,
                decoration: BoxDecoration(
                  color: balon.color,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 20,
            child: Hero(
              tag: 'balon${balon.image}',
              child: Container(
                height: 220,
                width: 220,
                child: Image.asset(balon.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
