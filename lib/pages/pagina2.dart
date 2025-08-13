import 'package:flutter/material.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pagina3');
        },
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      appBar: AppBar(
        title: const Text('Pagina 2', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/pagina1');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              textTheme: ButtonTextTheme.primary,
              onPressed: () {
                Navigator.pushNamed(context, '/pagina1');
              },
              animationDuration: const Duration(seconds: 1),
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: const Text('Establecer Usuario'),
            ),
              MaterialButton(
              textTheme: ButtonTextTheme.primary,
              onPressed: () {
                Navigator.pushNamed(context, '/pagina1');
              },
              animationDuration: const Duration(seconds: 1),
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: const Text('Cambiar Edad'),
            ),
              MaterialButton(
              textTheme: ButtonTextTheme.primary,
              onPressed: () {
                Navigator.pushNamed(context, '/pagina1');
              },
              animationDuration: const Duration(seconds: 1),
              color: Colors.deepPurple,
              textColor: Colors.white,
              child: const Text('Añadir Profesión'),
            ),
          ],
        ),
      ),
    );
  }
}
