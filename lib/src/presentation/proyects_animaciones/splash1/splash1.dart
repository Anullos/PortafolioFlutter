import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects_animaciones/splash1/home1.dart';

class Splash1Screen extends StatelessWidget {
  const Splash1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Home1Screen()));
        },
        child: Hero(
          tag: 'fondo',
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.green,
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Text('Púlsame'),
            ),
          ),
        ),
      ),
    );
  }
}
