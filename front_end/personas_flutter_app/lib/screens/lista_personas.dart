import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'crear_persona.dart';
import 'editar_persona.dart';

class ListaPersonas extends StatefulWidget {
  @override
  State<ListaPersonas> createState() => _ListaPersonasState();
}

class _ListaPersonasState extends State<ListaPersonas> {
  late Future<List<dynamic>> personas;

  @override
  void initState() {
    super.initState();
    personas = ApiService.listarPersonas();
  }

  void actualizarLista() {
    setState(() {
      personas = ApiService.listarPersonas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personas", style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Nueva Persona"),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CrearPersona()),
          );
          actualizarLista();
        },
      ),

      body: FutureBuilder(
        future: personas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data ?? [];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              final persona = data[i];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    persona["nombre"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Edad: ${persona["edad"]} • Sexo: ${persona["sexo"]}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditarPersona(id: persona["id"]),
                            ),
                          );
                          actualizarLista();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await ApiService.eliminarPersona(persona["id"]);
                          actualizarLista();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
