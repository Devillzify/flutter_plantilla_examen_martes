import 'package:flutter/material.dart';
import 'package:plantilla_examen/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/datum.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProviders>(context);
    final usuarios = users.listaUsers;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Drawer"),
              ),
              ListTile()
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => {Navigator.pushNamed(context, 'dbLocal')},
                icon: Icon(Icons.add_moderator))
          ],
          title: const Text('PeticionBasicaHTTP'),
        ),
        body: ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(usuarios[index].id.toString()),
                title: Text(usuarios[index].firstName),
                subtitle: Text(usuarios[index].lastName),
                trailing: Image.network(usuarios[index].avatar),
              );
            }));
  }
}
