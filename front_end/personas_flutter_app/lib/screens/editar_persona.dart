import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditarPersona extends StatefulWidget {
  final int id;

  EditarPersona({required this.id});

  @override
  State<EditarPersona> createState() => _EditarPersonaState();
}

class _EditarPersonaState extends State<EditarPersona> {
  final nombreCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  String sexo = "M";

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() async {
    var data = await ApiService.obtenerPersona(widget.id);
    setState(() {
      nombreCtrl.text = data["nombre"];
      edadCtrl.text = data["edad"].toString();
      sexo = data["sexo"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Persona")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: "Nombre",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: edadCtrl,
              decoration: InputDecoration(
                labelText: "Edad",
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: sexo,
              decoration: InputDecoration(
                labelText: "Sexo",
                prefixIcon: Icon(Icons.transgender),
              ),
              items: const [
                DropdownMenuItem(value: "M", child: Text("Masculino")),
                DropdownMenuItem(value: "F", child: Text("Femenino")),
              ],
              onChanged: (v) => setState(() => sexo = v!),
            ),

            SizedBox(height: 24),

            ElevatedButton.icon(
              icon: Icon(Icons.update),
              label: Text("Actualizar"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                await ApiService.actualizarPersona(
                  widget.id,
                  nombreCtrl.text,
                  int.parse(edadCtrl.text),
                  sexo,
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
