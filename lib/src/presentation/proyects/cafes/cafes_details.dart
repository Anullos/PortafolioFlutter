import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_models.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_variables.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/widgets/custom_appbar.dart';

class CafesDetails extends StatelessWidget {
  final Cafe cafe;
  const CafesDetails({Key key, @required this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(),
          // Titulo cafe
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.4,
                  alignment: Alignment.center,
                  child: Hero(
                    tag: '${cafe.name}',
                    child: Material(
                      child: Text(
                        cafe.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorBrownText,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Imagen cafe
          Positioned(
            top: size.height * 0.25,
            right: 0,
            left: 0,
            child: Hero(
              tag: '${cafe.idCafe}',
              child: Container(
                height: size.height * 0.40,
                child: Image.asset(cafe.image),
              ),
            ),
          ),
          //Tamaños
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.stay_primary_landscape,
                        size: 35,
                      ),
                      Text(
                        'S',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.memory_rounded,
                        size: 45,
                      ),
                      Text(
                        'M',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.brightness_5_outlined,
                        size: 35,
                      ),
                      Text(
                        'S',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Footer
          Positioned(
            bottom: 0,
            left: 40,
            right: 40,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hot / Warm',
                      style: TextStyle(
                        color: cafe.isHot ? colorBrownText : Colors.grey,
                        fontSize: 24,
                        fontWeight:
                            cafe.isHot ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 5,
                      color: Colors.grey,
                    ),
                    Text('Cold / Ice',
                        style: TextStyle(
                          color: cafe.isHot ? Colors.grey : colorBrownText,
                          fontSize: 24,
                          fontWeight:
                              cafe.isHot ? FontWeight.normal : FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
