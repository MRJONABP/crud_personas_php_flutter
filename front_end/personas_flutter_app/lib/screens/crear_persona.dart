import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CrearPersona extends StatefulWidget {
  @override
  State<CrearPersona> createState() => _CrearPersonaState();
}

class _CrearPersonaState extends State<CrearPersona> {
  final nombreCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  String sexo = "M";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear Persona")),

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
              icon: Icon(Icons.save),
              label: Text("Guardar"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                await ApiService.crearPersona(
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
