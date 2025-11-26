import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.2/crud_persona_api/public";

  // Listar personas
  static Future<List<dynamic>> listarPersonas() async {
    final response = await http.get(Uri.parse("$baseUrl/personas"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener personas");
    }
  }

  // Crear persona
  static Future<bool> crearPersona(String nombre, int edad, String sexo) async {
    final response = await http.post(
      Uri.parse("$baseUrl/personas"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "edad": edad,
        "sexo": sexo,
      }),
    );

    return response.statusCode == 200;
  }

  // Obtener persona por ID
  static Future<dynamic> obtenerPersona(int id) async {
    final response =
    await http.get(Uri.parse("$baseUrl/personas/$id"));

    return jsonDecode(response.body);
  }

  // Actualizar persona
  static Future<bool> actualizarPersona(
      int id, String nombre, int edad, String sexo) async {
    final response = await http.put(
      Uri.parse("$baseUrl/personas/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": nombre,
        "edad": edad,
        "sexo": sexo
      }),
    );

    return response.statusCode == 200;
  }

  // Eliminar persona
  static Future<bool> eliminarPersona(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/personas/$id"),
    );

    return response.statusCode == 200;
  }
}
