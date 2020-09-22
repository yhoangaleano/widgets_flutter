import 'package:flutter/material.dart';

import 'package:componentes/src/screens/alert_screen.dart';
import 'package:componentes/src/screens/animated_container_screen.dart';
import 'package:componentes/src/screens/avatar_screen.dart';
import 'package:componentes/src/screens/card_screen.dart';
import 'package:componentes/src/screens/home_screen.dart';
import 'package:componentes/src/screens/inputs_screen.dart';
import 'package:componentes/src/screens/slider_screen.dart';
import 'package:componentes/src/screens/list_view_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeScreen(),
    'alert': (BuildContext context) => AlertScreen(),
    'animatedContainer': (BuildContext context) => AnimatedContainerScreen(),
    'avatar': (BuildContext context) => AvatarScreen(),
    'card': (BuildContext context) => CardScreen(),
    'inputs': (BuildContext context) => InputsScreen(),
    'listView': (BuildContext context) => ListViewScreen(),
    'slider': (BuildContext context) => SliderScreen(),
  };
}
