import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_provider.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_variables.dart';

class CustomAppBar extends StatelessWidget {
  final bool cambiar;
  const CustomAppBar({Key key, this.cambiar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = CafesProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icono back
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  if (cambiar) {
                    provider.cambio = false;
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 30,
                  color: provider.cambio ? colorBrownText : Colors.white,
                ),
              ),
              // Carrito
              Container(
                child: Stack(
                  children: [
                    // Icono carrito
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 35,
                          color:
                              provider.cambio ? colorBrownText : Colors.white,
                        ),
                      ),
                    ),
                    // Contador Carrito
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              provider.cambio ? colorBrownText : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '2',
                          style: TextStyle(
                            color:
                                provider.cambio ? Colors.white : colorBrownText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
