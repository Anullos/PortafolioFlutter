import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects_animaciones/hero_planiffai/second_plannifai.dart';

class HomePlannifai extends StatelessWidget {
  const HomePlannifai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0,
        title: Text('Clientes'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.5),
          ),
          Hero(
            tag: 'clientes',
            child: Material(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Buscador
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SecondPlannifai(),
                                  );
                                },
                              ),
                            );
                          },
                          child: Text('proebando')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
