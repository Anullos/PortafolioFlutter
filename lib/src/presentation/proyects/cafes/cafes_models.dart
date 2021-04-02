import 'package:flutter/material.dart';

class Cafe {
  String idCafe;
  String name;
  String image;
  double price;
  bool isHot;

  Cafe({
    @required this.idCafe,
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.isHot,
  });
}
