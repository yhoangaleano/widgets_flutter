import 'package:flutter/material.dart';

// Nos permite realizar la internacionalización
import 'package:flutter_localizations/flutter_localizations.dart';

// Configuración de las rutas para la aplicación
import 'package:componentes/src/routes/routes.dart';

// Paginas con las que se trabajaron los ejemplos y cuando
// no se tenian las configruaciones de ruta
// import 'package:componentes/src/screens/home_temp_screen.dart';
// import 'package:componentes/src/screens/home_screen.dart';

// Pagina por defecto
import 'package:componentes/src/screens/alert_screen.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nos permite aplicar la internacionalización a los widgets
      // tanto de material como de cupertino
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Lenguajes soportados por flutter y que nos permite
      // aplicarlo a cualquier componente, como el de la fecha
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('es', 'CO'), // Spanish
      ],
      title: 'Componentes App',
      // Permite quitar la banderita que muestra que esta en modo debug
      debugShowCheckedModeBanner: false,
      // Obtengo la configuración de mis rutas
      routes: getApplicationRoutes(),
      // home: HomeTempScreen(),
      // home: HomeScreen(),
      // Establezco la ruta inicial de la aplicación
      initialRoute: '/',
      // Cuando una ruta no existe, se llama este metodo que permite
      // tomar medidas, como llamar una pagina por defecto 
      onGenerateRoute: (RouteSettings settings) {
        print('La ruta llamada: ${settings.name} no existe.');

        return MaterialPageRoute(
            builder: (BuildContext context) => AlertScreen());
      },
    );
  }
}