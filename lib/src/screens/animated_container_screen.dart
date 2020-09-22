import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerScreen extends StatefulWidget {
  @override
  _AnimatedContainerScreenState createState() => _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.pink;

  BorderRadiusGeometry _borderRadiusGeometry = BorderRadius.circular(8.0);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animated Container'),
        ),
        body: Center(
          child: AnimatedContainer(
            width: _width,
            height: _height,
            // No olvidar que para establecer color, border radius
            // y demas propiedades de diseño a un Container
            // se debe hacer uso del BoxDecoration
            decoration: BoxDecoration(
                borderRadius: _borderRadiusGeometry, color: _color
            ),
            // Permite saber que tiempo dura en cambiar su contenido
            // y lo hace por medio de la animación
            duration: Duration(milliseconds: 300),
            // Son diferentes tipos de animaciones que nos permiten
            // animar este container. Funciona como la librerías
            // de animate.css
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.play_circle_filled),
            onPressed: _cambiarForma
        )
    );
  }

  void _cambiarForma() {

    final random = Random();

    setState(() {
      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();
      _color = Color.fromRGBO(
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
        1
      );
      _borderRadiusGeometry = BorderRadius.circular(random.nextInt(100).toDouble());

    });
  }
}