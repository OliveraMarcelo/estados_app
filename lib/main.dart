import 'package:estados_app/pages/pagina1.dart';
import 'package:estados_app/pages/pagina2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/pagina1',
      routes: {
        '/pagina1': (context) => const Pagina1Page(),
        '/pagina2': (context) => const Pagina2Page(),
        '/pagina3': (context) => const CssUnitsExample(),
      },
    );
  }
}

