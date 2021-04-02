import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_models.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_variables.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/widgets/custom_appbar.dart';

class CafesDetails extends StatefulWidget {
  final Cafe cafe;
  const CafesDetails({Key key, @required this.cafe}) : super(key: key);

  @override
  _CafesDetailsState createState() => _CafesDetailsState();
}

class _CafesDetailsState extends State<CafesDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animBtnAdd;
  Animation animFooter;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    animBtnAdd = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    animFooter = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(cambiar: false),
          // Titulo cafe
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.5,
                  alignment: Alignment.center,
                  child: Hero(
                    tag: '${widget.cafe.name}',
                    child: Material(
                      child: Text(
                        widget.cafe.name,
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
            top: size.height * 0.27,
            right: 0,
            left: 0,
            child: Hero(
              tag: '${widget.cafe.idCafe}',
              child: Container(
                height: size.height * 0.40,
                child: Image.asset(widget.cafe.image),
              ),
            ),
          ),
          // Texto Precio
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: 210 * animBtnAdd.value + 0,
                left: 70 * animBtnAdd.value - 0,
                child: Text(
                  '${widget.cafe.price.toInt()}€',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 30,
                          offset: Offset(0.5, 0.5)),
                    ],
                  ),
                ),
              );
            },
          ),
          //Footer
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: -300 + animFooter.value * 300,
                child: Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Tamaños
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                child: Image.asset('assets/cafes/taza_s.png'),
                              ),
                              Text(
                                'S',
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                margin: EdgeInsets.only(left: 10),
                                child: Image.asset('assets/cafes/taza_m.png'),
                              ),
                              Text(
                                'M',
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                margin: EdgeInsets.only(left: 10),
                                child: Image.asset('assets/cafes/taza_l.png'),
                              ),
                              Text(
                                'L',
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Hot y cold
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hot / Warm',
                              style: TextStyle(
                                color: widget.cafe.isHot
                                    ? colorBrownText
                                    : Colors.grey,
                                fontSize: 24,
                                fontWeight: widget.cafe.isHot
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 5,
                              color: Colors.grey,
                            ),
                            Text(
                              'Cold / Ice',
                              style: TextStyle(
                                color: widget.cafe.isHot
                                    ? Colors.grey
                                    : colorBrownText,
                                fontSize: 24,
                                fontWeight: widget.cafe.isHot
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          // Icono Añadir
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                //duration: const Duration(milliseconds: 1000),
                top: size.height * 0.25,
                right: 0 + animBtnAdd.value * size.width * 0.2,
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Icon(Icons.add),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
