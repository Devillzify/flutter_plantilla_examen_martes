import 'package:flutter/material.dart';
import 'package:plantilla_examen/providers/db_provider.dart';
import 'package:plantilla_examen/providers/user_list_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class Local extends StatefulWidget {
  const Local({super.key});

  @override
  State<Local> createState() => _LocalState();
}

class _LocalState extends State<Local> {
  @override
  Widget build(BuildContext context) {
    List<Datum> listaUsers = [];
    final usuarios = Provider.of<UserListProvider>(context);
    usuarios.carregaUsuarios();
    listaUsers = usuarios.users;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local DB'),
      ),
      body: ListView.builder(
        itemCount: listaUsers.length,
        itemBuilder: (BuildContext context, index) => Dismissible(
          key: Key(usuarios.users[index].id.toString()),
          background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete_forever),
              )),
          child: ListTile(
            onTap: () => {},
            leading: Image.network(listaUsers[index].avatar),
            title: Text(listaUsers[index].firstName),
            subtitle: Text(listaUsers[index].lastName),
            trailing: Text(listaUsers[index].email),
          ),
          onDismissed: (DismissDirection direction) {
            setState(() {
              usuarios.esborraPerId(listaUsers[index].id);
            });
            print(listaUsers.length);
          },
        ),
      ),
    );
  }
}
