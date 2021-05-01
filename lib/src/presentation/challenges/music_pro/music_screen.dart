import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/challenges/music_pro/music_model.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key key}) : super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _alturaFactorAnimacion;
  double alturaPantalla = 0;
  bool isOpening = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _alturaFactorAnimacion = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onTap() {
    _controller.forward();
    isOpening = true;
  }

  _handleVerticalUpdate(DragUpdateDetails updateDetails) {
    double fractionDragged = updateDetails.primaryDelta / alturaPantalla;
    // el -5 es para la velocidad del arrastre que detecta
    if (fractionDragged > 0) {
      _controller.value = _controller.value - 5 * fractionDragged;
    }
  }

  _handleVerticalEnd(DragEndDetails endDetails) {
    //0.4 es que cuando va por la mitad hace una cosa
    if (_controller.value >= 0.4) {
      _controller.forward();
    } else {
      _controller.reverse();
      isOpening = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    alturaPantalla = size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Listado de Musica
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              itemCount: musics.length,
              itemBuilder: (context, index) {
                final musicItem = musics[index];
                return MusicItem(
                  musicItem: musicItem,
                  onTap: () {},
                );
              },
            ),
            // Custom Bottom Bar
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: onTap,
                    onVerticalDragUpdate: _handleVerticalUpdate,
                    onVerticalDragEnd: _handleVerticalEnd,
                    child: FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: _alturaFactorAnimacion.value * 0.45 + 0.15,
                      widthFactor: _alturaFactorAnimacion.value * 0.5 + 0.5,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: (1 - _alturaFactorAnimacion.value) * 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF5233FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  _alturaFactorAnimacion.value * 24 + 16.0),
                              topRight: Radius.circular(
                                  _alturaFactorAnimacion.value * 24 + 16.0),
                              bottomLeft: Radius.circular(
                                  (1 - _alturaFactorAnimacion.value) * 16.0),
                              bottomRight: Radius.circular(
                                  (1 - _alturaFactorAnimacion.value) * 16.0),
                            ),
                          ),
                          child: CustomBottomBar(
                            isOpen: isOpening,
                            factorAnimacion: _controller.value,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  final bool isOpen;
  final double factorAnimacion;
  const CustomBottomBar({
    Key key,
    this.isOpen,
    this.factorAnimacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final opacity = (2 * (factorAnimacion - 0.3)).clamp(0.0, 1.0);
    return Container(
      child: isOpen
          ? Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF230CB2), offset: Offset(0, 8))
                        ],
                      ),
                      child: Image.asset(
                        musics[0].image,
                        height: 120,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    'Lord Crebury',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  flex: 1,
                  child: Text(
                    musics[0].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                //Ocultar mientras baja
                Flexible(
                  flex: 3,
                  child: Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Center(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              final random = Random();
                              final color = Color(
                                  int.parse('0xFF${random.nextInt(999999)}'));
                              return Align(
                                widthFactor: 0.8,
                                child: ColorItem(
                                  color: color,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Ocultar mientras baja
                Flexible(
                  flex: 1,
                  child: Opacity(
                    opacity: opacity,
                    child: SizedBox(
                      width: 240,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.repeat,
                            size: 30,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.pause,
                            size: 30,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.settings_backup_restore_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.library_add_outlined,
                  size: 30,
                  color: Colors.white,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(int.parse(musics[0].color)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(musics[0].image),
                  ),
                ),
                Icon(
                  Icons.work_outline,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
    );
  }
}

class MusicItem extends StatelessWidget {
  final MusicModel musicItem;
  final VoidCallback onTap;
  const MusicItem({Key key, this.musicItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: Color(int.parse(musicItem.color)),
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Opacity(
                      opacity: 0.6, child: Image.asset(musicItem.image)),
                ),
              ),
              Positioned(
                top: 20,
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        musicItem.image,
                      ),
                    ),
                    Text(
                      musicItem.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  final Color color;
  const ColorItem({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
