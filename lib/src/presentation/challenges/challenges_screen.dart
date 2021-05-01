import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/challenges/music_pro/music_screen.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_screen.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: Text('Challenges'),
      ),
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
                      .push(MaterialPageRoute(builder: (_) => CafesScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '1. Coffe',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MusicScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '2. Music',
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
