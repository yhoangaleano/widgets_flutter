import 'package:flutter/material.dart';

// Nos permite trabajar para formatear las fechas
import 'package:intl/intl.dart';

class InputsScreen extends StatefulWidget {
  @override
  _InputsScreenState createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  String _nombre = '';
  String _email = '';
  String _password = '';
  String _fecha = '';

  String _opcionSeleccionada = 'Volar';
  List<String> _poderes = ['Volar', 'Rayos x', 'Super Aliento', 'Super Fuerza'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        children: <Widget>[
          _crearPersona(),
          Divider(),
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropdown(),
        ],
      ),
    );
  }

  // Se crea este Card para que se visualice los cambios
  // realizados en el formulario al escribir o seleccionar
  Widget _crearPersona() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(_nombre),
            subtitle: Text(_email),
            leading: Icon(Icons.info),
            trailing: Text(_opcionSeleccionada),
          ),
        ],
      ),
    );
  }

  Widget _crearInput() {
    return TextField(
        // Colaca el foco cuando se abre el widget
        autofocus: false,
        // Permite que la primera letra de cada sentencia
        // se coloque en mayúscula
        textCapitalization: TextCapitalization.sentences,
        // Permite aplicar el hintText (placeholder)
        // El label, los iconos, borderRadius, etc.
        decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20.0)
          // ),
          // Texto que se ubica en la parte derecha inferior
          counter: Text('Letras ${_nombre.length}'),
          // Funciona como el texto de ejemplo que aparece
          // al poner focus en el campo
          hintText: 'Yhoan Galeano',
          labelText: 'Nombre',
          helperText: 'Texto de ayuda',
          // Icono en la parte izquierda
          icon: Icon(Icons.people),
          // Icono en la parte derecha
          suffixIcon: Icon(Icons.accessibility),
        ),
        // Permite identificar cuando cambia el valor del texto
        onChanged: (valor) {
          setState(() {
            _nombre = valor;
          });
        });
  }

  Widget _crearEmail() {
    return TextField(
      // Permite especificar que tipo de campo
      // voy a trabajar
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          helperText: 'Ingrese solo información personal',
          hintText: 'Ejm: johndoe@mail.com',
          labelText: 'Correo electrónico',
          icon: Icon(Icons.mail)),
      onChanged: (valor) {
        setState(() {
          _email = valor;
        });
      },
    );
  }

  Widget _crearPassword() {
    return TextField(
      // Permite que el texto se cambie a un password
      obscureText: true,
      decoration: InputDecoration(
        hintText: '123456',
        labelText: 'Contraseña',
        icon: Icon(Icons.lock),
      ),
      onChanged: (valor) {},
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      // No permite ni copiar, ni pegar
      // Si es true, al presionar este campo de texto,
      // se seleccionará el texto y se mostrará el menú
      // de cortar/copiar/pegar.
      enableInteractiveSelection: false,
      // Como otro metodo se encarga de setear el valor al elemento
      // se debe crear un TextEditingController para poder acceder a
      // este campo y establecer su valor
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        hintText: '05-07-1993',
        labelText: 'Fecha de nacimiento',
        icon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        // Al pararse encima de campo, el focus del elemento se pierde
        // para que al llamar al método que se encarga de levantar el calendario
        // no se quede en el campo
        FocusScope.of(context).requestFocus(new FocusNode());
        // Para poder levantar el calendario, como es parecido a un modal
        // se le debe pasar el contexto para saber donde se debe levantar
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    // Nos permite formatear las fechas por medio del paquete
    // ----- intl ----- que se importo en la parte de arriba
    final f = new DateFormat('dd-MM-yyyy');
    // El showDatePicker al fin y al cabo retorna un Future<DateTime>
    // Por esta razón es que toca crear el método como async y esperar
    // el retorno con el await
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1910),
      lastDate: new DateTime.now(),
      // Para que esta internacionalización funcione, toca realizar
      // la instalación del paquete flutter_localizations y agregar una
      // configuración al main.dart
      locale: Locale('es', 'CO'),
    );

    // Se valida que se haya seleccionado algo del calendario
    // de ser así, se formatea para mostrar y se establece al controlador
    // editing del campo de fecha.
    if (picked != null) {
      setState(() {
        _fecha = f.format(picked).toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearDropdown() {
    // Como el dropdown no trae las propiedades para mostrar iconos al inicio
    // entonces se encapsula dentro de un row (que permite colocar elementos de)
    // forma horizontal, despues se coloca el icono, luego el SizeBox para darle
    // un espacio entre el icono y el DropdownButton. Luego para que este elemento
    // ocupe el resto del espacio del row, se encapsula dentro de un Expanded
    return Row(children: <Widget>[
      Icon(Icons.select_all),
      SizedBox(width: 15.0),
      Expanded(
          child: DropdownButton(
        // Al poner en true, este campo ocupa todo el tamaño del contenedor.
        // En este caso tenemos un row y el Dropdown esta dentro de un expanded
        // para que se expanda en su maximo tamaño
        isExpanded: true,
        // Por defecto establezco una propiedad que tiene uno de los valores
        // de los items que tendra el dropdown. Cada vez que este se cambie,
        // se debe establecer su valor para que se muestre al usuario
        value: _opcionSeleccionada,
        // Se llama el metodo que se encarga de devolver la lista de DropdownMenuItem
        items: _getOpcionesDropdown(),
        // Cuando se selecciona una opción del dropdown, se llama este método
        // que establece el option seleccionado a la propiedad que tiene el valor
        onChanged: (String opt) {
          setState(() {
            _opcionSeleccionada = opt;
          });
        },
      ))
    ]);
  }

  // Para poder trabajar con los Dropdown necesitamos tener una lista de
  // DropdownMenuItem. Para este caso, lo que hacemos es crear una Lista de
  // string, le hacemos un map para recorrer y devolver un nuevo objeto
  // (DropdownMenuItem) que tenga las propiedades que se necesitan
  // como el mapa me devuelve un iterable, lo convierto al final a un toList()
  List<DropdownMenuItem<String>> _getOpcionesDropdown() {
    return _poderes
        .map((poder) => new DropdownMenuItem(
              child: Text(poder),
              value: poder,
            ))
        .toList();
  }
}
