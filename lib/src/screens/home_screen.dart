import 'package:flutter/material.dart';

// Servicio que me permite obtener los iconos desde un string
import 'package:icons_helper/icons_helper.dart';

// Modelo que tienes las propiedades que se mostraran en la lista
import 'package:componentes/src/models/opciones_menu.model.dart';

// Servicio donde tenemos la lectura del .json
import 'package:componentes/src/providers/menu_provider.dart';

// Servicio que nos permite obtener un icono, con un string
import 'package:componentes/src/utils/icono_string_util.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    // El future builder me permite crear widgets de los cuales necesitamos data
    // de un servicio asincrono, para poder trabajar y sacar la información que allí nos
    // trae. 
    return FutureBuilder<List<OpcionesMenuModel>>(
      // Leemos el metodo que devuelve el future
      future: menuProvider.cargarData(),
      // La información que tendra el FutureBuilder mientras se resuelve
      initialData: [],
      // Metodo que se encarga de recibir el contexto que pemrite redibujar
      // y la información que resuelve el future.
      // El snapshot posee la información de si ocurrio
      // un error, si aun no tiene data y una variable llamada
      // data que es donde viene el objeto con el cual trabajaremos
      builder: (
        BuildContext context,
        AsyncSnapshot<List<OpcionesMenuModel>> snapshot
      ) {
        // Creo el Widget del ListView
        return ListView(
          children: _listaItems( snapshot.data, context ),
        );
      },
    );
  }

  // El context acá es necesario porque permite saber
  // cual pagina estaba antes, que pagina es la que siga,
  // tiene toda esa información
  List<Widget> _listaItems(List<OpcionesMenuModel> data, BuildContext context) {

    final List<Widget> opciones = [];

    data.forEach((opt) {

      final widgetTemp = ListTile(
        title: Text(opt.texto),
        // leading: getIcon(opt.icon),
        leading: Icon(
          getIconGuessFavorMaterial(name: opt.icon),
          color: Colors.blue
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blue
        ),
        onTap: () {

          // Estas formas de navegar con el MaterialPageRoute
          // Es la manera en como lo haría para pasar de un a ruta
          // a otro si no fuese dinamica
          // final route = MaterialPageRoute(
          //   builder: (BuildContext context) {
          //     return AlertPage();
          //   }
          // );
          // final route = MaterialPageRoute(
          //   builder: (BuildContext context) => AlertPage(),
          // );
          // Navigator.push(context, route);


          // Este metodo funciona muy parecido a la opcion
          // anterior, pero utilizando un nombre de ruta
          // para estas rutas se deben configurar una lista de rutas
          // que se debe inyectar en el main.dart
          Navigator.pushNamed(context, opt.ruta);

        },
      );

      opciones..add(widgetTemp)
              ..add(Divider());

    });

    return opciones;
  }
}
