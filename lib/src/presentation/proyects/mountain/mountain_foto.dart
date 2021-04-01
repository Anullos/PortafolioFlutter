import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/mountain/mountain_model.dart';

class MountainFoto extends StatelessWidget {
  const MountainFoto({Key key, this.mountain}) : super(key: key);
  final Mountain mountain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              constrained: false,
              child: Image.asset(
                mountain.images[0],
                scale: 1.0,
                //fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: 30,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black54.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'x',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
