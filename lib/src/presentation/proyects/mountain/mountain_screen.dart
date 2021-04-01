import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/mountain/mountain_details.dart';
import 'package:portafolio_flutter/src/presentation/proyects/mountain/mountain_foto.dart';
import 'package:portafolio_flutter/src/presentation/proyects/mountain/mountain_model.dart';

class MountainScreen extends StatefulWidget {
  const MountainScreen({Key key}) : super(key: key);

  @override
  _MountainScreenState createState() => _MountainScreenState();
}

class _MountainScreenState extends State<MountainScreen> {
  int currentIndex = 0;
  bool adelante = false;
  bool atras = false;
  List<dynamic> cardProps = [];

  void changeMountain(DragUpdateDetails details) {
    if (details.primaryDelta < 0 && currentIndex < 2) {
      adelante = true;
    } else if (details.primaryDelta > 0 && currentIndex > 0) {
      atras = true;
    }
  }

  void setCardProps() {
    Size screenSize = MediaQuery.of(context).size;

    if (currentIndex == 0) {
      cardProps = [
        {
          'top': screenSize.height * 0.35,
          'left': -(screenSize.width * 0.65),
          'leftDot': screenSize.width * 0.15,
          'opacity': 1.0,
        },
        {
          'top': screenSize.height * 0.38,
          'left': screenSize.width * 0,
          'leftDot': screenSize.width * 0.40,
          'opacity': 0.4,
        },
        {
          'top': screenSize.height * 0.41,
          'left': screenSize.width * 0.25,
          'leftDot': screenSize.width * 0.4,
          'opacity': 0.1,
        }
      ];
    } else if (currentIndex == 1) {
      cardProps = [
        {
          'top': screenSize.height * 0.35,
          'left': -(screenSize.width * 0.69),
          'leftDot': (screenSize.width * 0.25),
          'opacity': 0.0,
        },
        {
          'top': screenSize.height * 0.38,
          'left': -screenSize.width * 0.42,
          'leftDot': screenSize.width * 0.20,
          'opacity': 1.0,
        },
        {
          'top': screenSize.height * 0.41,
          'left': screenSize.width * 0.07,
          'leftDot': screenSize.width * 0.4,
          'opacity': 0.4,
        }
      ];
    } else {
      cardProps = [
        {
          'top': screenSize.height * 0.35,
          'left': -(screenSize.width * 0.69),
          'leftDot': -(screenSize.width * 0),
          'opacity': 0.0,
        },
        {
          'top': screenSize.height * 0.38,
          'left': -screenSize.width * 0.45,
          'leftDot': -(screenSize.width * 0.1),
          'opacity': 0.0,
        },
        {
          'top': screenSize.height * 0.41,
          'left': -(screenSize.width * 0.25),
          'leftDot': screenSize.width * 0.30,
          'opacity': 1.0,
        }
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    setCardProps();
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: (_) {
          adelante = false;
          atras = false;
        },
        onHorizontalDragEnd: (_) {
          if (adelante) {
            setState(() {
              currentIndex++;
            });
          } else if (atras) {
            setState(() {
              currentIndex--;
            });
          }
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          changeMountain(details);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Mountain.defaultList()[currentIndex].colors[0],
                Mountain.defaultList()[currentIndex].colors[1],
              ],
            ),
          ),
          child: Stack(
            children: List<Widget>.generate(Mountain.defaultList().length,
                (int index) {
              final mountain = Mountain.defaultList()[index];
              return MountainCard(
                mountain: mountain,
                index: index,
                buttonTag: 'boton_${mountain.name}',
                heroTag: 'hero_${mountain.name}',
                currentIndex: currentIndex,
                props: cardProps[index],
              );
            }).reversed.toList(),
          ),
        ),
      ),
    );
  }
}

class MountainCard extends StatelessWidget {
  final Mountain mountain;
  final int index;
  final String heroTag;
  final String buttonTag;
  final int currentIndex;
  final dynamic props;

  const MountainCard(
      {Key key,
      this.mountain,
      this.index,
      this.heroTag,
      this.buttonTag,
      this.currentIndex,
      this.props})
      : super(key: key);

  double opacidad() {
    if (currentIndex == index) {
      return 1;
    } else if (currentIndex <= index) {
      return 0.5;
    } else {
      return 0;
    }
  }

  double imagenLeft(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (index == 0 && currentIndex != index) {
      return -(screenSize.width * 0.27);
    } else if (index == 1 && currentIndex != index) {
      return screenSize.width * 0.14;
    } else if (index == 2 && currentIndex != index) {
      return 200;
    } else {
      return 0;
    }
  }

  double posDotTop() {
    if (index == 0) {
      return 535;
    } else if (index == 1) {
      return 255;
    } else {
      return 305;
    }
  }

  double posDotLeft() {
    if (index == 0) {
      return 30;
    } else if (index == 1) {
      return 180;
    } else {
      return 240;
    }
  }

  Tween<double> escalaName() {
    if (index == currentIndex) {
      return Tween<double>(begin: 1, end: 1);
    } else if (index < currentIndex) {
      return Tween<double>(begin: 1, end: 1.1);
    } else {
      return Tween<double>(begin: 1, end: 1);
    }
  }

  Tween<Offset> tweenMonte() {
    if (index == currentIndex) {
      return Tween<Offset>(begin: Offset(-50, 0), end: Offset(0, 0));
    } else if (index < currentIndex) {
      return Tween<Offset>(begin: Offset(0, 0), end: Offset(-50, 0));
    } else {
      return Tween<Offset>(begin: Offset(50, 0), end: Offset(50, 0));
    }
  }

  Tween<Offset> tweenBoton() {
    if (index == currentIndex) {
      return Tween<Offset>(begin: Offset(0, 0), end: Offset(1000, 0));
    } else {
      return Tween<Offset>(begin: Offset(1000, 0), end: Offset(0, 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // imagen principal
          AnimatedPositioned(
            top: props['top'],
            //left: currentIndex <= index ? 0 : 100,
            left: props['left'],
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              child: AnimatedOpacity(
                //currentIndex <= index ? 1 : 0,
                opacity: props['opacity'],
                duration: const Duration(milliseconds: 200),
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 200),
                  tween: escalaName(),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      alignment: Alignment.bottomRight,
                      child: Hero(
                        tag: heroTag,
                        child: Image.asset(
                          mountain.images[0],
                          //fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            top: props['top'] - 15,
            left: props['leftDot'],
            duration: const Duration(milliseconds: 450),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: currentIndex == index ? 1 : 0,
              child: SummitDot(
                mountain: mountain,
                index: index,
              ),
            ),
          ),
          // texto
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // nombre del monte
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: currentIndex == index ? 1 : 0,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, top: 20),
                          child: TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 300),
                            tween: escalaName(),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  mountain.name.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // detalles
                    Expanded(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: currentIndex == index ? 1 : 0,
                        curve: Curves.easeInOut,
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 300),
                          tween: tweenMonte(),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: value,
                              child: DetallesMonte(
                                index: index,
                                mountain: mountain,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // boton mountain details
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 200,
            right: currentIndex == index ? 0 : -500,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: currentIndex == index ? 1 : 0,
              curve: Curves.easeInOut,
              child: BotonMonte(
                tagboton: buttonTag,
                mountain: mountain,
                props: props,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetallesMonte extends StatelessWidget {
  final Mountain mountain;
  final int index;
  const DetallesMonte({Key key, this.index, this.mountain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 45),
        Text('Elevation',
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
        Text('${mountain.elevation.toString()} / Ranked ${mountain.ranked}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15)),
        SizedBox(height: 7),
        Text('Coordinates',
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
        Text(mountain.coordinates,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15)),
      ],
    );
  }
}

class BotonMonte extends StatelessWidget {
  final String tagboton;
  final Mountain mountain;
  final dynamic props;
  const BotonMonte({Key key, this.tagboton, this.mountain, this.props})
      : super(key: key);

  void nextPage2(BuildContext context, Mountain mountain, dynamic props) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: MountainDetails(mountain: mountain, props: props),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 30,
        child: TextButton(
          onPressed: () => nextPage2(context, mountain, props),
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.white.withOpacity(0.35)),
              padding: MaterialStateProperty.resolveWith((states) =>
                  EdgeInsets.symmetric(horizontal: 20, vertical: 0)),
              shape: MaterialStateProperty.resolveWith((states) =>
                  BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2)))),
          child: Hero(
            tag: tagboton,
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Text('Information'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5)),
                  SizedBox(width: 4),
                  Icon(Icons.monetization_on, color: Colors.white, size: 11)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SummitDot extends StatelessWidget {
  final int index;
  final Mountain mountain;
  const SummitDot({Key key, this.mountain, this.index}) : super(key: key);

  void nextPage1(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, _) {
          return ScaleTransition(
            scale: animation,
            child: MountainFoto(),
          );
        }));
  }

  void nextPage2(BuildContext context, Mountain mountain) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: MountainFoto(mountain: mountain),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return (index == 2)
        ? Row(
            children: [
              InkWell(
                onTap: () => nextPage2(context, mountain),
                child: Icon(
                  Icons.arrow_circle_down_sharp,
                  color: Colors.white30,
                  size: 35,
                ),
              ),
              Container(
                height: 1,
                width: 60,
                color: Colors.white,
              ),
              Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )
        : Row(
            children: [
              Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 1,
                width: 60,
                color: Colors.white,
              ),
              InkWell(
                onTap: () => nextPage2(context, mountain),
                child: Icon(
                  Icons.arrow_circle_down_sharp,
                  color: Colors.white30,
                  size: 35,
                ),
              ),
            ],
          );
  }
}
