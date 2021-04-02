import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_variables.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/widgets/custom_appbar.dart';

class CafesScreen extends StatelessWidget {
  const CafesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Fondo Pantalla
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.25, 1],
                  colors: [
                    colorBackground,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          // APP BAR
          CustomAppBar(),
          // Cuarto
          Positioned(
            top: size.height * 0.12,
            left: (size.width * 0.3),
            right: (size.width * 0.3),
            child: Container(
              width: size.width,
              child: Hero(
                tag: '9',
                child: Image.asset(
                  'assets/cafes/9.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Tercero
          Positioned(
            top: size.height * 0.2,
            left: (size.width * 0.1),
            right: (size.width * 0.1),
            child: Container(
              width: size.width,
              child: Hero(
                tag: '11',
                child: Image.asset(
                  'assets/cafes/11.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Segundo
          Positioned(
            top: size.height * 0.35,
            left: -(size.width * 0.22),
            right: -(size.width * 0.22),
            child: Container(
              width: size.width,
              child: Hero(
                tag: '8',
                child: Image.asset(
                  'assets/cafes/8.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Primero
          Positioned(
            top: size.height * 0.82,
            left: -(size.width * 0.5),
            right: -(size.width * 0.5),
            child: Container(
              width: size.width,
              child: Hero(
                tag: '1',
                child: Image.asset(
                  'assets/cafes/1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Texto Portada
          Positioned(
            top: size.height * 0.6,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FIKA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Coffee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
