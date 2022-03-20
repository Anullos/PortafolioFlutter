import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/futbol/futbol_details.dart';
import 'package:portafolio_flutter/src/presentation/proyects/futbol/futbol_model.dart';

class FutbolScreen extends StatefulWidget {
  const FutbolScreen({Key? key}) : super(key: key);

  @override
  _FutbolScreenState createState() => _FutbolScreenState();
}

class _FutbolScreenState extends State<FutbolScreen> {
  final _pageController = PageController(initialPage: 0);
  final _priceNotifier = ValueNotifier<int>(balones.first.price);
  int lastPrice = 0;
  double currentPage = 0.0;

  @override
  void initState() {
    lastPrice = balones.first.price;
    _pageController.addListener(_setcurrentPage);
    super.initState();
  }

  _setcurrentPage() {
    setState(() {
      currentPage = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_setcurrentPage);
    _pageController.dispose();
    _priceNotifier.dispose();
    super.dispose();
  }

  void _tapDetails(BuildContext context, Balon balon) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: FutbolDetails(balon: balon),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Sports store',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 20.0),
                child: _botonesChicos(),
              ),
              _botonesChicos(),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    _priceNotifier.value = balones[index].price;
                    lastPrice = balones[index].price;
                  },
                  itemCount: balones.length,
                  itemBuilder: (context, index) {
                    final balon = balones[index];
                    final percent = (currentPage - index).abs().clamp(0.0, 1.0);
                    final opacity = percent.clamp(0.0, 0.9);
                    final scale = percent.clamp(0.0, 0.7);
                    return Opacity(
                      opacity: 1 - opacity,
                      child: BalonItem(
                        balon: balon,
                        scale: scale,
                        onTap: () => _tapDetails(context, balon),
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _priceNotifier,
                        builder: (context, value, child) {
                          return TweenAnimationBuilder(
                            tween: IntTween(
                              begin: lastPrice,
                              end: value,
                            ),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, animationValue, child) {
                              return Text(
                                '$animationValue',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tallas disponibles'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          BotonChico(numero: '3'),
                          BotonChico(numero: '4'),
                          BotonChico(numero: '5'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/dani.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daniel Aranda',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text('Málaga'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.home, size: 30),
                Icon(Icons.card_giftcard, size: 30, color: Colors.grey),
                Icon(Icons.card_travel, size: 30, color: Colors.grey),
                Icon(Icons.star, size: 30, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BotonChico extends StatelessWidget {
  final String numero;
  const BotonChico({Key? key, required this.numero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(numero),
      ),
    );
  }
}

Widget _botonesChicos() {
  return ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
    ),
    child: Row(
      children: [
        Icon(
          Icons.ad_units,
          color: Colors.black,
          size: 18.0,
        ),
        Text(
          'Soccer ball',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

double balonSize = 200.0;

class BalonItem extends StatelessWidget {
  final Balon balon;
  final VoidCallback onTap;
  final double scale;
  const BalonItem(
      {Key? key, required this.balon, required this.onTap, required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PARTE IZQUIERDA
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 25,
                            left: 25,
                            child: Hero(
                              tag: 'name${balon.color}',
                              child: Container(
                                width: 100,
                                child: Material(
                                  child: Text(
                                    balon.name,
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // PARTE DERECHA
                  Expanded(
                    child: Hero(
                      tag: 'container${balon.color}',
                      child: Container(
                        decoration: BoxDecoration(
                          color: balon.color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 40,
                              left: 20,
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  balon.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // BALON
              Positioned(
                top: 0,
                bottom: 0,
                left: (size.width / 2 - (balonSize / 2) + scale * 80),
                child: Hero(
                  tag: 'balon${balon.image}',
                  child: Transform.scale(
                    scale: (1 - scale),
                    child: Container(
                      height: balonSize,
                      width: balonSize,
                      child: Image.asset(balon.image),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
