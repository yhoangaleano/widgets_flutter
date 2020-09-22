// Me permite acceder al json.decode para decodificar el json
import 'dart:convert';

// Paquete de flutter que me permite leer un archivo .json
import 'package:flutter/services.dart' show rootBundle;

// Modelos
import 'package:componentes/src/models/opciones_menu.model.dart';

class _MenuProvider {
  
  // Propiedad que se llena con las opciones que se leen del json
  List<OpcionesMenuModel> opciones = [];

  // Se retorna un Future ya que la función esta marcada con el async
  // y el await. Ese Future dentro de el tiene la lista de objetos
  // que se pintaran en el Menú. Este objeto es List<OpcionesMenuModel>
  Future<List<OpcionesMenuModel>> cargarData() async {
    // Leemos el archivo .json
    // No olvidar que como es un recurso estatico, se debe ir al
    // pubspec.yaml y buscar los assets, descomentarlo y agregar la carpeta
    // data y el menu_opts.json
    final resp = await rootBundle.loadString('data/menu_opts.json');
    // Decodificamos el objeto json a un mapa para dart
    Map dataMap = json.decode(resp);
    // Del mapa accedemos a la key rutas
    opciones = dataMap['rutas'].map<OpcionesMenuModel>((x) => OpcionesMenuModel.fromJson(x))
          .toList();
    // Retornamos las opciones que se pintaran en el menú
    return opciones;
  }

}

// Creo una instancia de la clase _MenuProvider para que
// durante la ejecución de toda la app, solo se cree una vez
final menuProvider = new _MenuProvider();
