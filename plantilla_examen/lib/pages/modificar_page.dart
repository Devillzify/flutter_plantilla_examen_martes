import 'package:flutter/material.dart';
import 'package:plantilla_examen/models/datum.dart';

class Modify extends StatefulWidget {
  Datum user =
      new Datum(id: 0, email: "", firstName: "", lastName: "", avatar: "");

  Modify(Datum usuario) {
    user.id = usuario.id;
    user.email = usuario.email;
    user.firstName = usuario.firstName;
    user.lastName = usuario.lastName;
    user.avatar = usuario.avatar;
  }
  @override
  State<Modify> createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
