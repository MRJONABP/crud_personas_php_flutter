<?php
require_once __DIR__ . "/../models/Persona.php";


class PersonaController {

    public function listar($db) {
        $persona = new Persona($db);
        $stmt = $persona->listar();

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result);
    }

    public function crear($db) {
        $data = json_decode(file_get_contents("php://input"));

        $persona = new Persona($db);
        $persona->nombre = $data->nombre;
        $persona->edad = $data->edad;
        $persona->sexo = $data->sexo;

        if ($persona->crear()) {
            echo json_encode(["mensaje" => "Persona creada correctamente"]);
        } else {
            echo json_encode(["mensaje" => "Error al crear persona"]);
        }
    }

    public function obtener($db, $id) {
        $persona = new Persona($db);
        $persona->id = $id;

        $data = $persona->obtenerPorId();
        echo json_encode($data);
    }

    public function actualizar($db, $id) {
        $data = json_decode(file_get_contents("php://input"));

        $persona = new Persona($db);
        $persona->id = $id;
        $persona->nombre = $data->nombre;
        $persona->edad = $data->edad;
        $persona->sexo = $data->sexo;

        if ($persona->actualizar()) {
            echo json_encode(["mensaje" => "Persona actualizada"]);
        } else {
            echo json_encode(["mensaje" => "Error al actualizar"]);
        }
    }

    public function eliminar($db, $id) {
        $persona = new Persona($db);
        $persona->id = $id;

        if ($persona->eliminar()) {
            echo json_encode(["mensaje" => "Persona eliminada"]);
        } else {
            echo json_encode(["mensaje" => "Error al eliminar"]);
        }
    }
}
