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
    $nome         = mysqli_real_escape_string($conexao, $_GET['nome']);
    $email         = mysqli_real_escape_string($conexao, $_GET['email']);
    $pontuacao     = mysqli_real_escape_string($conexao, $_GET['pontuacao']);
    $senha         = mysqli_real_escape_string($conexao, $_GET['senha']);

    $sql="insert into jogador (nome, email, pontuacao, senha) VALUES ('$nome', '$email', $pontuacao, '$senha')";
    mysqli_query($conexao, $sql);    
    $linhas_afetadas = mysqli_affected_rows($conexao);
    
    if ($linhas_afetadas>0) {
        echo "Os dados foram inseridos no banco de dados!";
    }else{
        echo "Não foi possível inserir nenhuma linha no banco de dados!";
    }
}catch(Exception $e){
    echo "Ocorreu o seguinte erro: ".$e->getMessage();
}finally{
    mysqli_close($conexao);    
}

?>
