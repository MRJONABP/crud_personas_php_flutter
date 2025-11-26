<?php
require_once __DIR__ . "/../controllers/PersonaController.php";
require_once __DIR__ . "/../config/database.php";

$db = (new Database())->getConnection();
$controller = new PersonaController();

$method = $_SERVER["REQUEST_METHOD"];
$path = explode('/', trim($_SERVER["REQUEST_URI"], '/'));

if ($path[0] === "crud_persona_api" || $path[0] === "personas" ) {

    // Cuando accedes como /crud_persona_api/public/personas
    if ($path[0] === "crud_persona_api") {
        if (isset($path[2]) && $path[1] === "public") {
            $path = array_slice($path, 2);
        }
    }

    // /personas
    if ($method === "GET" && count($path) === 1 && $path[0] === "personas") {
        $controller->listar($db);
    }

    // /personas/{id}
    if ($method === "GET" && count($path) === 2) {
        $controller->obtener($db, $path[1]);
    }

    if ($method === "POST" && $path[0] === "personas") {
        $controller->crear($db);
    }

    if ($method === "PUT" && count($path) === 2) {
        $controller->actualizar($db, $path[1]);
    }

    if ($method === "DELETE" && count($path) === 2) {
        $controller->eliminar($db, $path[1]);
    }
}
