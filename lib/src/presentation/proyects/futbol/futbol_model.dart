import 'package:flutter/material.dart';

class Balon {
  String name;
  String image;
  int price;
  Color color;

  Balon({
    required this.name,
    required this.image,
    required this.price,
    required this.color,
  });
}

final List<Balon> balones = [
  Balon(
    name: 'Nike Blanco',
    image: 'assets/futbol/balon1.png',
    price: 35,
    color: Colors.green,
  ),
  Balon(
    name: 'Balon clasico',
    image: 'assets/futbol/balon2.png',
    price: 10,
    color: Colors.blue,
  ),
  Balon(
    name: 'Baloncesto',
    image: 'assets/futbol/balon3.png',
    price: 15,
    color: Colors.pink,
  ),
  Balon(
    name: 'Nike Negro',
    image: 'assets/futbol/balon4.png',
    price: 45,
    color: Colors.yellow,
  ),
  Balon(
    name: 'Adidas Pro',
    image: 'assets/futbol/balon5.png',
    price: 30,
    color: Colors.purple,
  ),
];
