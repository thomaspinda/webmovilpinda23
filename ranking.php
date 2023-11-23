<?php
$conexion = pg_connect("host=localhost dbname=Usuario user=postgres password=bigboobz")
    or die('No se ha podido conectar: ' . pg_last_error());

$query = "SELECT US_NOM, US_PUN, US_RES FROM USUARIO ORDER BY US_PUN DESC";

// Ejecutar la consulta
$result = pg_query($query) or die('La consulta fallo: ' . pg_last_error());

echo '<style>
    @font-face {
        font-family: "Arcade";
        src: url("ka1.ttf") format("truetype");
    }
    body { background-color: #24289d;
        font-family: "Arcade",sans-serif; }
    h1 { color: white; text-align: center; }
    ol { padding: 0; margin: 0; list-style-type: none; }
    li { margin-bottom: 10px; padding: 10px; border-radius: 5px; background-color: #87CEEB; width: 300px; display: inline-block; }
    .gold { background-color: #FFD700; }
    .silver { background-color: #C0C0C0; }
    .bronze { background-color: #CD7F32; }
    .button-container { text-align: center; }
    .search-button { padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; }
</style>';
echo '<h1>Ranking por Puntos</h1>';
echo '<ol>';
echo '</ol>';
echo '<div class="button-container">
        <a href="buscador.php" class="search-button">Ir al Buscador</a>
      </div>';

$contador = 0;
while ($row = pg_fetch_assoc($result)) {
    $contador++;
    $liClass = '';
    if ($contador == 1) {
        $liClass = 'gold';
    } elseif ($contador == 2) {

        $liClass = 'silver';
    } elseif ($contador == 3) {

        $liClass = 'bronze';
    }
    echo '<li class="' . $liClass . '">';
    echo '<strong>' . $contador . '. ' . $row['us_nom'] . '</strong><br>Puntos: ' . $row['us_pun'] . '<br>Respuestas: ' . $row['us_res'];
    echo '</li>';
}



pg_free_result($result);
pg_close($conexion);
?>


