import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cards')),
      body: ListView(
        // Padding en todos los lados, se puede controlar
        // De manera vertical, horizotal - symmetric
        // De manera indivial (arriba, abajo, izquierda, derecha) - only
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo3()
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      // Permite establecer una sombra al card
      elevation: 10.0,
      // Permite hacer el border radios al card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text('Soy el titulo de la tarjeta'),
            subtitle: Text(
                'Aqui estamos con la descripción de la tarjeta para mostrar varia informacion bien brutal'),
          ),
          Row(
            // Permite que los botones se alinien de manera vertical al final
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    // Si utilizo acá el componente de Card y no Container
    // se verian los bordes de una manera como pixelada
    final card = Container(
      // Este clipBehavior permite que el contenido del card
      // (la imagen) no se salga del contenido de la card
      // En el momento de trabajar este proyecto no funciono
      // Recordar que esta propiedad es de una card y no de un
      // Container
      // clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          // Permite colocar una imagen y que mientras se cargue, se muestre un recurso estatico
          // que permita simular el cargando de las imagenes
          FadeInImage(
            image: NetworkImage(
                'https://tecnovortex.com/wp-content/uploads/2019/04/wallpaper-engine.jpg'),
            // Imagen que se muestra mientras se carga la imagen de internet
            placeholder: AssetImage('assets/original_tits.jpg'),
            // Permite crear una animación para la entrada de la imagen que se carga
            fadeInDuration: Duration(milliseconds: 200),
            // Para que la imagen no se mueva y quede un tamaño fijo, utilizamos esta propiedad
            // Con un alto especifico
            height: 300.0,
            // Permite especificar como la imagen debe ocupar el espacio que tiene disponible
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('No tengo idea de que poner'),
          ),
        ],
      ),
    );

    // Un contendor es como una caja donde puedo colocar elementos
    // Muy similar a lo que es un div en html
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            // Permite crear la sombra del elemento
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  // Atenuación
                  blurRadius: 10.0,
                  // Tamaño de la atenuación
                  spreadRadius: 2.0,
                  // Cordenada en x y en y en donde se va a ver la sombra
                  offset: Offset(2.0, 10.0))
            ]),
        // Este widget ClipRRect permite cortar cualquier elemento
        // que se salga del contenedor. En este caso si colocaramos
        // el card como child, las puntas estarian puntiagudas
        // y no se veria el borderRadius que tiene el contenedor
        // en su propiedad decoration. Este componente
        // tambien recibe un borderRadius y un child
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: card,
        ));
  }

  // Trabaja similar al componente anterior y utiliza la propiedad
  // clipBehavior: Clip.antiAlias para que se aplique de manera adecuada el
  // borde redondeado
  Widget _cardTipo3() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                'https://tecnovortex.com/wp-content/uploads/2019/04/wallpaper-engine.jpg'),
            placeholder: AssetImage('assets/loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('No tengo idea de que poner'),
          ),
        ],
      ),
    );
  }
}
