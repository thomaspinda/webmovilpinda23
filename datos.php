<?php
$conexion = pg_connect("host=localhost dbname=Usuario user=postgres password=bigboobz");
$usuario = $_POST["Usuario"];
$contraseña = $_POST["Contrasena"];

$query = "SELECT * FROM Usuario WHERE US_NOM = $1";
$result = pg_query_params($conexion, $query, array($usuario));

if (pg_num_rows($result) > 0) {
    header("Location: Error.html");
    } else {
    $query = "INSERT INTO Usuario (US_NOM, US_CONT) VALUES ($1, $2)";
    $result = pg_query_params($conexion, $query, array($usuario, $contraseña));
    header("Location: Home.html");
}
?>
