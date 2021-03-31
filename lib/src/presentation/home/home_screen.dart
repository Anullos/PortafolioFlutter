import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/animaciones/anim_screen.dart';
import 'package:portafolio_flutter/src/presentation/demos/demos_screen.dart';
import 'package:portafolio_flutter/src/presentation/home/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Text('Portafolio Anullos'),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DemosScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Demos',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AnimacionesScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Animaciones',
                    style: TextStyle(fontSize: 20.0),
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
