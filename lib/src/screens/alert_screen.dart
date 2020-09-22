import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alertas')),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar alerta'),
          textColor: Colors.white,
          color: Colors.blue,
          // Permite que el boton quede con los bordes redondeados
          shape: StadiumBorder(),
          onPressed: () => _mostrarAlerta(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          // Me permite regresar ya que el contexto sabe de donde viene
          Navigator.pop(context);
        },
      ),
    );
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        // El context de la pagina en la cual se mostrara la alerta
        context: context,
        // Se puede cerrar haciendo click afuera
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('Titulo'),
            content: Column(
              // Toma el minimo del tamaño que tiene
              // Se ajusta el tamaño del contenido que tenga la columna
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Contenido de la caja de la alerta'),
                FlutterLogo(size: 100.0)
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancelar'),
                  // Cierra la alerta
                  onPressed: () => Navigator.of(context).pop()),
              FlatButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    // Cierra la alerta
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
