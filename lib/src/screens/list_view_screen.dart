import 'dart:async';

import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<int> _lista;
  int _ultimoItem = 0;

  // Variable que me sirve para saber si se esta cargando o no
  // simulando una petición http con un future
  bool _cargando = false;

  // Me permite controlar el scroll de la lista
  // para determinar cuando esta llego a su maximo de pixeles
  // y llamar de nuevo la fución que carga otras 10 imagenes
  // como si fuera un scroll infinito
  ScrollController _scrollController = new ScrollController();

  // Método del ciclo de vida de StatefulWidget
  @override
  void initState() {
    super.initState();
    _lista = new List();
    _agregar10();
    _scrollController.addListener(() {
      // La primera parte me dice cual es el tamaño que tiene actualmente mi scroll
      // contra lo que comparo es cuanto es el maximo de pixeles que tiene mi pantalla
      // si estos dos son iguales, es porqye llegue hasta el final de la lista
      // y llamo un metodo que se encarga de simular una llamada http
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _agregar10();
        _obtenerDatos();
      }
    });
  }

  // cada vez que me salgo de la pagina lo que hago es borrar el listener
  // para que no se quede escuchando y creando nuevos listener cada vez que entro
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      // El Stack me permite apilar elementos uno encima del otro
      // en este caso, la lista aparece por debajo y el loading aparece por encima
      body: Stack(children: <Widget>[_crearLista(), _crearCargando()]),
    );
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: _obtenerDatosRefrescar,
      // Este constructor de la lista se utiliza cuando no sabemos
      // cuantos elemento tendra la lista. De esta manera se van pintando
      // conforme van llegando los elementos que se presentaran.
      child: ListView.builder(
          // Este controlador me permite saber cuando llego al final de
          // la lista por medio de un listener. Al llegar al final
          // puedo llamar otros 10 elementos para que se vea un scroll infinito
          controller: _scrollController,
          // Estas propiedades son obligatorias para saber cuantos items tiene
          // y el metodo que se encarga de crear la lista
          itemCount: _lista.length,
          // Este metodo es el que se encarga de dibujar los items
          // necesita del buildContext para saber en donde se deben pintar
          itemBuilder: (BuildContext context, int index) {
            final tamanioImagen = _lista[index];
            return FadeInImage(
              placeholder: AssetImage('assets/original_tits.jpg'),
              image: NetworkImage(index % 2 == 0
                  ? 'https://source.unsplash.com/random/500x${ (300+tamanioImagen).toString() }'
                  : 'https://source.unsplash.com/collection/190727/500x${ (300+tamanioImagen).toString() }'),
              fit: BoxFit.fill,
            );
          }),
    );
  }

  void _agregar10() {
    final int inicio = _ultimoItem;
    for (var i = inicio; i < (inicio + 10); i++) {
      setState(() {
        _ultimoItem++;
        _lista.add(_ultimoItem);
      });
    }
  }

  Future _obtenerDatosRefrescar() async {
    final duration = new Duration(seconds: 2);
    new Timer(duration, () {
      _lista.clear();
      _ultimoItem++;
      _agregar10();
    });
    return Future.delayed(duration);
  }

  // Simulo una llamada a un servicio http
  // coloco la propiedad que tengo para saber si esta cargando en true
  // recordemos que cada vez que cambio una propiedad y se quiere que se renderice
  // se debe llamar el setState
  // creo la duration que me sirve para pasarlo como parametro a timer
  // recordar que para el Timer debo importar una librería de dart
  // el timer recibe el tiempo que va a simular y un metodo que recibe
  // el callback al cumplirse el tiempo
  Future<Null> _obtenerDatos() async {
    setState(() {
      _cargando = true;
    });
    final duration = new Duration(seconds: 2);
    return new Timer(duration, respuestaHttp);
  }

  // coloco la propiedad que tengo para saber si esta cargando en false
  // recordemos que cada vez que cambio una propiedad y se quiere que se renderice
  // se debe llamar el setState, pero como acá llamo el _agregar10 que ya tiene
  // el setState, no hay necesidad.
  // animamos el scroll para que apenas carga me muestra 100 pixeles abajo
  // que da como una sensación de que hay mas registros
  // recordar que los curves son los tipos de animaciones que se pueden utilizar
  void respuestaHttp() {
    _cargando = false;
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        duration: new Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
    _agregar10();
  }

  // Si la variable de cargando se coloca en true, en el stack aparece
  // por encima un loading pequeñito.
  // Para que se vea bien se coloca dentro de una columna que ocupa todo
  // el alto de la pantalla gracias a la propiedad mainAxisSize
  // y los hijos los ubica al final de todo el alto
  // el row permite que el elemento del loading se ubique en el centro
  // de la pantalla gracias a su propiedad mainAxisAlignment
  // y para que el no se vea tan pegado al borde inferior, como hijo del
  // column se coloca un SizedBox con un espacio de alto que permite
  // que el loading no quede tan pegado
  Widget _crearCargando() {
    if (_cargando == true) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()]),
          SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }
}
