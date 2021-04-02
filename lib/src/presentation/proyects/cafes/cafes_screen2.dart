import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_data.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_details.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_models.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_provider.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_variables.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class CafesScreen2 extends StatefulWidget {
  const CafesScreen2({Key key}) : super(key: key);

  @override
  _CafesScreen2State createState() => _CafesScreen2State();
}

class _CafesScreen2State extends State<CafesScreen2>
    with TickerProviderStateMixin {
  final _pageController = PageController(initialPage: 0);
  AnimationController _controllerTop;
  AnimationController _controllerBottom;
  Animation<Color> _animColor;
  Animation<double> _tituloTop;
  Animation<double> _opacidadTop;
  Animation<double> _tituloBottom;
  CafesProvider provider;
  double _currentIndex = 0;
  bool _adelante = false;
  bool _atras = false;
  bool cambio = false;

  void changeCafe(DragUpdateDetails details) {
    if (details.primaryDelta < 0 && _currentIndex < cafes.length) {
      this._adelante = true;
    } else if (details.primaryDelta > 0 && _currentIndex > 0) {
      this._atras = true;
    }
  }

  _setcurrentPage() {
    setState(() {
      _currentIndex = _pageController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_setcurrentPage);
    _controllerTop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _tituloTop = Tween(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(
        parent: _controllerTop,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animColor = ColorTween(begin: colorBackground, end: Colors.white)
        .animate(_controllerTop);
    _opacidadTop = Tween(begin: 0.0, end: 1.0).animate(_controllerTop);
    _controllerBottom = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _tituloBottom = Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _controllerBottom,
      curve: Curves.easeOut,
    ));

    _controllerTop.forward();
    _controllerBottom.forward();

    super.initState();
    setState(() {
      cambio = true;
    });
  }

  @override
  void dispose() {
    _controllerTop.dispose();
    _controllerBottom.dispose();
    super.dispose();
  }

  double posTopList(BuildContext context, int index) {
    final size = MediaQuery.of(context).size;
    if (index == _currentIndex) {
      return 150 - (size.height * (0 * 0.12));
    } else if (index == _currentIndex + 1) {
      return 150 - (size.height * (1 * 0.12));
    } else if (index == _currentIndex + 2) {
      return 150 - (size.height * (2 * 0.12));
    } else {
      return 150 - (size.height * (0 * 0.12));
    }
  }

  double posLeftList(BuildContext context, int index) {
    final size = MediaQuery.of(context).size;
    if (index == _currentIndex) {
      return (size.width * 0.03 + (0 * 30));
    } else if (index == _currentIndex + 1) {
      return (size.width * 0.03 + (1 * 30));
    } else if (index == _currentIndex + 2) {
      return (size.width * 0.03 + (2 * 30));
    } else {
      return (size.width * 0.03 + (3 * 30));
    }
  }

  double posOpacidad(int index) {
    if (index == _currentIndex) {
      return 1;
    } else if (index == _currentIndex + 1) {
      return 0.9;
    } else if (index == _currentIndex + 2) {
      return 0.4;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    provider = Provider.of<CafesProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          // Fondo Pantalla
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controllerTop,
              builder: (context, child) => child,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.25, 1],
                    colors: [
                      _animColor.value,
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomAppBar(),
          //Sombra abajo
          Positioned(
            bottom: -70,
            child: Container(
              height: size.height * .2,
              width: size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: colorBrownText,
                    blurRadius: 200.0,
                    spreadRadius: 25.0,
                  )
                ],
              ),
            ),
          ),
          //PageViewTitulos
          AnimatedBuilder(
            animation: _controllerTop,
            builder: (context, child) {
              return Positioned(
                top: -100 + 250 * _tituloTop.value,
                right: 0,
                left: 0,
                child: Opacity(
                  opacity: _opacidadTop.value,
                  child: Container(
                    width: size.width,
                    height: size.height * .2,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        provider.pagina = value;
                      },
                      itemCount: cafes.length,
                      itemBuilder: (context, index) {
                        final cafe = cafes[index];
                        final percent =
                            (_currentIndex - index).abs().clamp(0.0, 1.0);
                        final opacity = percent.clamp(0.0, 1.0);
                        return Opacity(
                          opacity: 1.0 - opacity,
                          child: ItemPage(
                            cafe: cafe,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          // Texto precio
          AnimatedBuilder(
            animation: _controllerTop,
            builder: (context, child) {
              return Positioned(
                top: -100 + 380 * _tituloTop.value,
                right: 0,
                left: 0,
                child: Opacity(
                  opacity: _opacidadTop.value,
                  child: Text(
                    '${cafes[provider.pagina].price}0€',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorBrownText,
                      fontSize: 28,
                    ),
                  ),
                ),
              );
            },
          ),
          // Lista cafes
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                changeCafe(details);
              },
              onVerticalDragStart: (_) {
                _adelante = false;
                _atras = false;
              },
              onVerticalDragEnd: (_) {
                if (_adelante) {
                  provider.pagina++;
                  setState(() {
                    _currentIndex++;
                    _pageController.animateToPage(
                      provider.pagina,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  });
                } else if (_atras) {
                  provider.pagina--;
                  setState(() {
                    _currentIndex--;
                    _pageController.animateToPage(
                      provider.pagina,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  });
                }
              },
              child: Container(
                width: size.width,
                height: size.height * 0.75,
                child: Stack(
                  children: List<Widget>.generate(cafes.length, (index) {
                    final cafe = cafes[index];
                    //double aux = (_currentIndex + 2);
                    //bool mostrar = (_currentIndex <= index) && (index >= aux);
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 250),
                      //top: 250 - (size.height * (index * 0.10)),
                      //right: (size.width * 0.03 + (index * 30)),
                      //left: (size.width * 0.03 + (index * 30)),
                      top: posTopList(context, index),
                      left: posLeftList(context, index),
                      right: posLeftList(context, index),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        //opacity: mostrar ? 1 : 0,
                        opacity: posOpacidad(index),
                        child: ItemCafe(
                          cafe: cafe,
                        ),
                      ),
                    );
                  }).reversed.toList(),
                ),
              ),
            ),
          ),

          // Menu Bottom
          AnimatedBuilder(
            animation: _controllerBottom,
            builder: (context, child) {
              return Positioned(
                bottom: -300 + 350 * _tituloBottom.value,
                right: 20,
                child: Text(
                  'Menu ->',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemCafe extends StatelessWidget {
  final Cafe cafe;
  const ItemCafe({Key key, this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(PageRouteBuilder(pageBuilder: (context, anim, _) {
          return FadeTransition(
            opacity: anim,
            child: CafesDetails(
              cafe: cafe,
            ),
          );
        }));
      },
      child: Hero(
        tag: '${cafe.idCafe}',
        child: Image.asset(
          cafe.image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  final Cafe cafe;
  const ItemPage({Key key, this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
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
    );
  }
}
