<?php

$conexao = null;

try{
    define('DB_SERVER', 'localhost');
    define('DB_USERNAME', 'root');
    define('DB_PASSWORD', '');
    define('DB_NAME', 'uninove');

    $conexao = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

    if (mysqli_connect_errno()) {
      echo "Falha na conexão com o MySQL: " . mysqli_connect_error();
      mysqli_close($conexao);
      exit();
    }

    mysqli_set_charset($conexao,"utf8");
    $id = mysqli_real_escape_string($conexao, $_GET['id']);    
    $sql="select * from jogador where id={$id}";
    $resultadoDoSelect = mysqli_query($conexao,$sql);

    $vetorLinhasDoBanco = array();
    while ($dadosjogador = mysqli_fetch_assoc($resultadoDoSelect)){
        $vetorLinhasDoBanco       = array();
        $vetorLinha["id"]          = $dadosjogador["id"];
        $vetorLinha["nome"]      = $dadosjogador["nome"];
        $vetorLinha["email"]      = $dadosjogador["email"]; 
        $vetorLinha["pontuacao"] = $dadosjogador["pontuacao"];
        $vetorLinha["senha"]      = $dadosjogador["senha"];
        $vetorLinhasDoBanco[]      = $vetorLinha;
    }

    if (count($vetorLinhasDoBanco)==0){
        echo "Nenhuma linha foi encontrada com o id = ".$id;
    }else{
        echo json_encode($vetorLinhasDoBanco);    
    }

}catch(Exception $e){
    echo "Ocorreu o seguinte erro: ".$e->getMessage();
}finally{
    mysqli_close($conexao);    
}

?>