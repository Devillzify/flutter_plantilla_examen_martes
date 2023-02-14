import 'package:flutter/material.dart';
import 'package:plantilla_examen/pages/pages.dart';
import 'package:plantilla_examen/preferences/preferences.dart';
import 'package:plantilla_examen/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProviders())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
      routes: {
        'home': (context) => HomePage(),
        'list': (context) => ListPage(),
      },
    );
  }
}
