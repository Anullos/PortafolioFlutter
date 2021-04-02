import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/home/home_screen.dart';
import 'package:portafolio_flutter/src/presentation/proyects/cafes/cafes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CafesProvider()),
      ],
      builder: (context, child) => child,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portafolio Anullos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
