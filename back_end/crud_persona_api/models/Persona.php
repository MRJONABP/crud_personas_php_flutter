<?php
class Persona {
    private $conn;
    private $table = "persona";

    public $id;
    public $nombre;
    public $edad;
    public $sexo;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Listar
    public function listar() {
        $query = "SELECT * FROM " . $this->table . " ORDER BY id DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Crear
    public function crear() {
        $query = "INSERT INTO " . $this->table . " (nombre, edad, sexo) 
                  VALUES (:nombre, :edad, :sexo)";

        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":nombre", $this->nombre);
        $stmt->bindParam(":edad", $this->edad);
        $stmt->bindParam(":sexo", $this->sexo);

        return $stmt->execute();
    }

    // Obtener por ID
    public function obtenerPorId() {
        $query = "SELECT * FROM " . $this->table . " WHERE id = :id LIMIT 1";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id", $this->id);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Actualizar
    public function actualizar() {
        $query = "UPDATE persona
                  SET nombre = :nombre,
                      edad = :edad,
                      sexo = :sexo
                  WHERE id = :id";

        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":nombre", $this->nombre);
        $stmt->bindParam(":edad", $this->edad);
        $stmt->bindParam(":sexo", $this->sexo);
        $stmt->bindParam(":id", $this->id);

        return $stmt->execute();
    }

    // Eliminar
    public function eliminar() {
        $query = "DELETE FROM persona WHERE id = :id";

        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $this->id);

        return $stmt->execute();
    }
}
