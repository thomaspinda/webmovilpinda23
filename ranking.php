<?php
// Configuración de la conexión a la base de datos PostgreSQL
$conexion = pg_connect("host=localhost dbname=Usuario user=postgres password=bigboobz")
    or die('No se ha podido conectar: ' . pg_last_error());

// Consulta SQL para obtener los datos de la tabla USUARIO ordenados por US_PUN de mayor a menor
$query = "SELECT US_NOM, US_PUN FROM USUARIO ORDER BY US_PUN DESC";

// Ejecutar la consulta
$result = pg_query($query) or die('La consulta fallo: ' . pg_last_error());
echo '<style>body { background-color: #24289d; }</style>';
echo '<ol start="1" style="padding: 0; margin: 0;">';
while ($row = pg_fetch_assoc($result)) {
    echo '<li style="margin-bottom: 10px; background-color: #87CEEB; padding: 10px; border-radius: 5px;">';
    echo '<strong>' . $row['us_nom'] . '</strong> - ' . $row['us_pun'];
    echo '</li>';
}
echo '</ol>';


pg_free_result($result);
pg_close($conexion);
?>