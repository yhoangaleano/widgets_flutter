import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int _valorSlider = 100;
  bool _valorCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders'),
      ),
      // Este contenedor permite encapsular varios elementos
      body: Container(
        // Se le da un espacio en la parte superior para que el primer
        // elemento se vea mejor
        margin: EdgeInsets.only(top: 20.0),
        // padding: EdgeInsets.only(top: 10.0),
        // Las columnas permiten apilar elementos de manera vertical
        child: Column(
          children: <Widget>[
            _crearCheckbox(),
            _crearSwitch(),
            _crearSlider(),
            // Se coloca en un Expanded para que ocupe lo que sobra de
            // las columnas en la pantalla
            Expanded(child: _crearImagen()),
          ],
        ),
      ),
    );
  }

  // Este método crea un CheckboxListTile el cual permite crear un texto
  // y un checkbox. Ademas tiene el método de onChanged que permite
  // obtener si el checkbox esta chequeado o no.
  // Se puede crear un Checkbox pero no aparece con el label
  Widget _crearCheckbox() {
    return CheckboxListTile(
      title: Text('Cambiar tamaño de la imagen'),
      value: _valorCheckbox,
      onChanged: (valor) {
        setState(() {
          _valorCheckbox = valor;
        });
      },
    );
  }

  // Este método crea un SwitchListTile (con la misma funcionalidad del checkbox
  // pero con una apariencia de switche) el cual permite crear un texto
  // y un switch. Ademas tiene el método de onChanged que permite
  // obtener si el switch esta chequeado o no
  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Cambiar tamaño de la imagen'),
      value: _valorCheckbox,
      onChanged: (valor) {
        setState(() {
          _valorCheckbox = valor;
        });
      },
    );
  }

  // Este método crear un Slider. Este elemento es como un range
  // que permite tener un rango minimo - maximo y poder establecer como
  // hace sus saltos (de 1 en 1, de 10 en 10) por medio de la propiedad
  // divisions. 
  Widget _crearSlider() {
    return Slider(
      // Ademas se le puede establecer un color cuando esta activo.
      activeColor: Colors.indigo,
      // Se establece un valor por defecto y cada vez que cambia se muestra al usuario
      value: _valorSlider.toDouble(),
      min: 0.0,
      max: 100.0,
      // Número que permite dar los saltos hasta llegar al numero máximo o visceversa
      divisions: 10,
      label: 'Tamaño de la imagen: $_valorSlider %',
      // cuando la propiedad de onChanged esta en null o no se llama este elemento
      // parece como si estuviese deshabilitado. Para el ejericio, se trabajo con una
      // variable que al hacer onChanged a los checkbox se coloca en true o en false
      // dependiendo del caso y en este slider se evalua y se establece o no el metodo
      // para que el usuario tenga la percepción de que esta activo e inactivo.
      // Cuando el método de onChanged esta activo, se obtiene el valor que se obtuvo
      // del slider y se lleva a una variable para que vaya cambiando el tamaño de la imagen
      // y el ejercicio sea un poco divertido. Recordar que esto pasa con todos los onChanged
      // de los elementos (Botones, DropdownButton, etc.)
      onChanged: _valorCheckbox
          ? (double valor) {
              setState(() {
                _valorSlider = valor.round();
              });
            }
          : null,
    );
  }

  Widget _crearImagen() {
    return FadeInImage(
      // Imagen que se muestra mientras se carga de internet
      placeholder: AssetImage('assets/original_tits.jpg'),
      image: NetworkImage(
          'https://pm1.narvii.com/6312/5162c9652d486cdbef4803376c7d6926acaac852_hq.jpg'),
      // Dependiendo del range se obtiene el valor del elemento que va maximo hasta 300
      width: _valorSlider.toDouble() * 3,
      // Ocupa todo el largo posible del contenedor
      fit: BoxFit.contain,
    );
  }
}
