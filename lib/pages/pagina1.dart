import 'package:flutter/material.dart';

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pagina2');
        },
        child: const Icon(Icons.arrow_right_rounded),
      ),
      body: InformationUser(),
    );
  }
}

class InformationUser extends StatelessWidget {
  const InformationUser({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('General', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Nombre'),
            subtitle: const Text('Marcelo Olivera'),
          ),
          const Text('Profesiones', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Profesión'),
            subtitle: const Text('Desarrollador Flutter'),
          ),
          
        ],
      ),
    );
  }
}

class CssUnits {
  final BuildContext context;
  final double baseSize; // Equivalente a 1rem en px lógicos

  CssUnits(this.context, {this.baseSize = 16});

  double rem(double multiplier) => baseSize * multiplier;

  double em(double parentFontSize, double multiplier) =>
      parentFontSize * multiplier;

  double vw(double percentage) =>
      MediaQuery.of(context).size.width * (percentage / 100);

  double vh(double percentage) =>
      MediaQuery.of(context).size.height * (percentage / 100);
}

class CssUnitsExample extends StatelessWidget {
  const CssUnitsExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos nuestro sistema de unidades CSS
    final css = CssUnits(context, baseSize: 16); // 1rem = 16px
    final parentFontSize = css.rem(1.2); // 1.2rem

    return Scaffold(
      body: Container(
        width: css.vw(100), // 50% del ancho de la pantalla
        height: css.vh(100), // 50% de la altura de la pantalla
        color: Colors.blue.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Texto en 1rem",
              style: TextStyle(fontSize: css.rem(1)), // 16px
            ),
            Text(
              "Texto en 1.5rem",
              style: TextStyle(fontSize: css.rem(1.5)), // 24px
            ),
            Text(
              "Texto en 1.2em (basado en padre)",
              style: TextStyle(
                  fontSize: css.em(parentFontSize, 1.2)), // 1.44 * base padre
            ),
            const SizedBox(height: 20),
            Container(
              width: css.vw(20), // 20% del ancho pantalla
              height: css.vh(10), // 10% del alto pantalla
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                "20vw x 10vh",
                style: TextStyle(fontSize: css.rem(0.8)), // 12.8px
              ),
            ),
          ],
        ),
      ),
    );
  }
}
