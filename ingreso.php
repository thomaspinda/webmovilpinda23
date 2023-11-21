<?php
$conexion = pg_connect("host=localhost dbname=Usuario user=postgres password=bigboobz");
$usuario=$_POST["Usuario1"];
$contraseña=$_POST["Contraseña1"];
$query = "SELECT * FROM Usuario WHERE US_NOM = $1 AND US_CONT = $2";
$result = pg_query_params($conexion, $query,array($usuario,$contraseña));
if(pg_num_rows($result) == 0){
    header("Location: Error2.html");
}else{
    header("Location: registrar.html?exito=true");
}
?>