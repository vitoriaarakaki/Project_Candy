<?php

define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_NAME', 'uninove');

$conexao = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

if (mysqli_connect_errno()) {
$vetorDeResposta = array();
$vetorDeResposta["erro"] = "Falha na conexão com o MySQL: " . mysqli_connect_error();
$vetorDeResposta["resultado"] = "";
echo json_encode($vetorDeResposta);
mysqli_close($conexao);
exit();
}

?>