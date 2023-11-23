<?php
$conexion = pg_connect("host=localhost dbname=Usuario user=postgres password=bigboobz");
$usuario = $_POST["Usuario"];
$contraseña = $_POST["Contrasena"];
$puntosNuevos = $_POST["PuntosAcumulados"];
$numRespuestas = $_POST["Respondidas"];

$query = "SELECT US_PUN FROM Usuario WHERE US_NOM = $1 AND US_CONT = $2";
$result = pg_query_params($conexion, $query, array($usuario, $contraseña));

if ($result) {
    $row = pg_fetch_assoc($result);

    if (isset($row['us_pun'])) {
        $puntosActuales = $row['us_pun'];
        $respuestasActuales = $row['us_res'];
        
        $puntosActualizados = $puntosActuales + $puntosNuevos;
        $respuestasActualizadas = $respuestasActuales + $numRespuestas;

        $updateQuery = "UPDATE Usuario SET US_PUN = $1, US_RES = US_RES + $2 WHERE US_NOM = $3";
        $updateResult = pg_query_params($conexion, $updateQuery, array($puntosActualizados, $numRespuestas, $usuario));

        if ($updateResult) {
            header("Location: Home.html");
        } else {
            echo "Error al actualizar los puntos en la base de datos";
        }
    } else {
    header("Location: Error2.html");
    }
} else {
    echo "Credenciales incorrectas";
}
?>
