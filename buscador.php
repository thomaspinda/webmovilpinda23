
<?php
$conexion = pg_connect("host=localhost dbname=Usuario user=postgres password=bigboobz")
    or die('No se ha podido conectar: ' . pg_last_error());
$usuarioBuscado = isset($_GET['usuario']) ? $_GET['usuario'] : '';
$query = "SELECT US_NOM, US_PUN, US_RES FROM USUARIO WHERE US_NOM = $1";
$result = pg_query_params($conexion, $query, array($usuarioBuscado));

echo '<style>
    body { background-color: #24289d; }
    h1 { color: white; text-align: center; }
    ol { padding: 0; margin: 0; list-style-type: none; }
    li { margin-bottom: 10px; padding: 10px; border-radius: 5px; background-color: #87CEEB; width: 300px; display: inline-block; }
    .gold { background-color: #FFD700; }
    .silver { background-color: #C0C0C0; }
    .bronze { background-color: #CD7F32; }
</style>';
echo '<h1>Ranking por Puntos</h1>';
echo '<form method="get" action="">
        <label for="usuario">Buscar Usuario:</label>
        <input type="text" name="usuario" id="usuario" value="' . htmlspecialchars($usuarioBuscado) . '">
        <input type="submit" value="Buscar">
      </form>';

echo '<ol>';
if ($row = pg_fetch_assoc($result)) {
    echo '<li class="' . '">';
    echo '<strong>'. $row['us_nom'] . '</strong><br>Puntos: ' . $row['us_pun'] . '<br>Respuestas: ' . $row['us_res'];
    echo '</li>';
} else {
    echo '<li>No se encontró ningún usuario con ese nombre.</li>';
}
echo '</ol>';

pg_free_result($result);
pg_close($conexion);
?>