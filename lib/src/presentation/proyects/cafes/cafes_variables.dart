import 'package:flutter/material.dart';

const Color colorBackground = Color(0xFFA78B68);
const Color colorBrownText = Color(0xFF422E2E);

// Propiedades de la lista de cafes para Stack
List<dynamic> cardProps = [];
void setCardProps(BuildContext context, int currentIndex) {
  Size size = MediaQuery.of(context).size;

  if (currentIndex == 0) {
    cardProps = [
      {
        'top': 430 - (size.height * (0 * 0.17)),
        'left': 0,
        'right': 0,
        'opacity': 1.0,
      },
      {
        'top': 430 - (size.height * (1 * 0.17)),
        'left': 0,
        'right': 0,
        'opacity': 0.7,
      },
      {
        'top': 430 - (size.height * (2 * 0.17)),
        'left': 0,
        'right': 0,
        'opacity': 0.4,
      }
    ];
  }
}
