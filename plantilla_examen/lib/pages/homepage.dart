// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../preferences/preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print(Preferences.user);
    print(Preferences.password);
    super.initState();
  }

  String usuario = Preferences.user;
  String password = Preferences.password;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final user = TextEditingController();
    final pass = TextEditingController();
    user.text = Preferences.user;
    pass.text = Preferences.password;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.8,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.blogs.es/8f5f2a/one-piece-luffy/1366_2000.jpeg"),
                  fit: BoxFit.cover,
                  opacity: 0.5)),
          child: Column(children: [
            TextField(
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              controller: user,
              onChanged: (value) {
                usuario = value;
                print(usuario);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(180, 224, 224, 224),
                  labelText: "Usuario",
                  hintText: "introduce un usuario",
                  labelStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            TextField(
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(180, 224, 224, 224),
                  labelText: "Password",
                  hintText: "introduce una contraseña",
                  labelStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              onChanged: (value) {
                password = value;
                print(password);
              },
              controller: pass,
            ),
            Divider(),
            Container(
              width: size.width * 0.06,
              height: size.height * 0.03,
              color: Color.fromARGB(180, 230, 230, 230),
              child: Checkbox(
                  value: Preferences.guardar,
                  onChanged: ((value) {
                    setState(() {
                      cambiar();
                    });
                  })),
            ),
            Divider(),
            ElevatedButton(onPressed: () => {validar()}, child: Text("Enviar"))
          ]),
        ),
      ),
    );
  }

  cambiar() {
    if (Preferences.guardar) {
      Preferences.guardar = false;
      print("no guardar ${Preferences.guardar}");
      Preferences.user = "";
      Preferences.password = "";
      usuario = Preferences.user;
      password = Preferences.password;
    } else {
      Preferences.guardar = true;
      print("guardar true ${Preferences.guardar}");
    }
  }

  validar() {
    if (password.length >= 5 && usuario.length >= 5) {
      if (Preferences.guardar) {
        print("aqui se guarda");
        setState(() {
          Preferences.user = usuario;
          Preferences.password = password;
        });
        Navigator.pushNamed(context, "list");
      } else {
        print("aqui no se guarda");
        setState(() {
          Preferences.user = "";
          Preferences.password = "";
          usuario = Preferences.user;
          password = Preferences.password;
        });
        Navigator.pushNamed(context, "list");
        print(Preferences.user);
        print(Preferences.password);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "El email y la contraseña deben tener almenos 5 caracteres")));
    }
  }
}
