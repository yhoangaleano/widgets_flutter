import 'package:flutter/material.dart';

class HomeTempScreen extends StatelessWidget {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> opciones = [
    'Uno',
    'Dos',
    'Tres',
    'Cuatro',
    'Cinco',
    'Seis'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Componentes Temp')),
      // Los ListView reciben una lista de widgets en sus children
      // List<Widget>. Para este caso como la lista es estatica
      // se trabaja con el constructor por defecto. Pero cuando
      // tengamos items dinamicos es correcto utilizar el constructor
      // ListView.builder el cual permite crear objetos a demanda
      // body: ListView(children: _crearItems()),
      body: ListView(children: _crearItemsCorta()),
    );
  }

  // Se crean los elementos que seran agregados a la lista y se retornan
  List<Widget> _crearItems() {
    List<Widget> lista = new List<Widget>();
    for (String opt in opciones) {
      final tempWidget = ListTile(title: Text(opt), onTap: () {
        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(content: Text('Doy click en el ListTile $opt'))
        );
      },);
      lista..add(tempWidget)..add(Divider());
    }
    return lista;
  }

  // Al igual que en javascript se rrecorre la lista de strings y
  // se crean los elementos que se devolveran para mostrar en la lista
  // Se crea dentro de un Column para colocar el ListTile de primero
  // y de segundo se muestra el Divider
  // Como al recorrer las opciones se devulve un Iterable, se debe pasar
  // a una List, para hacer esto, toca llamar el método toList()
  List<Widget> _crearItemsCorta() {
    return opciones.map((String opt) {
      return Builder(
        builder: (context) => Column(
          children: <Widget>[
            ListTile(
              title: Text(opt),
              subtitle: Text('Hola'),
              leading: Icon(Icons.access_time),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print('Doy click en el ListTile $opt');
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  new SnackBar(content: Text('Doy click en el ListTile $opt'))
                );
              },
            ),
            Divider()
          ],
        ),
      );
    }).toList();
  }
}
