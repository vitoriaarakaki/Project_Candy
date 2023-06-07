<?php

$conexao = null;

try{
        require('conexao.php'); 
        mysqli_set_charset($conexao,"utf8");
        $acao         = mysqli_real_escape_string($conexao, $_GET['acao']);
        $id         = mysqli_real_escape_string($conexao, $_GET['id']);
        $nome         = mysqli_real_escape_string($conexao, $_GET['nome']);
        $email         = mysqli_real_escape_string($conexao, $_GET['email']);
        $pontuacao     = mysqli_real_escape_string($conexao, $_GET['pontuacao']);
        $senha         = mysqli_real_escape_string($conexao, $_GET['senha']);

        if ($acao=="select"){
            $sql="select * from jogador where id={$id}";

            $resultadoDoSelect = mysqli_query($conexao,$sql);

            $vetorLinhasDoBanco = array();
            while ($dadosjogador = mysqli_fetch_assoc($resultadoDoSelect)){
                $vetorLinhasDoBanco      = array();
                $vetorLinha["id"]     = $dadosjogador["id"];
                $vetorLinha["nome"]     = $dadosjogador["nome"];
                $vetorLinha["email"]     = $dadosjogador["email"]; 
                $vetorLinha["pontuacao"] = $dadosjogador["pontuacao"];
                $vetorLinha["senha"]     = $dadosjogador["senha"];
                $vetorLinhasDoBanco[]     = $vetorLinha;
            }

            $vetorDeResposta = array();
            if (count($vetorLinhasDoBanco)>0){
                $vetorDeResposta["resultado"] = $vetorLinhasDoBanco;
            }else{
                $vetorDeResposta["resultado"] = "Nenhum registro foi encontrado!";
            }
            echo json_encode($vetorDeResposta);

        }else if ($acao=="insert"){
            $sql="insert into jogador (nome,email,pontuacao,senha) VALUES ('$nome','$email',$pontuacao,'$senha')";
            
            mysqli_query($conexao, $sql);
            $linhas_afetadas = mysqli_affected_rows($conexao);
            $vetorDeResposta = array();
            if ($linhas_afetadas>0) {
                $vetorDeResposta["resultado"] = "Dados inseridos com sucesso!";
                $vetorDeResposta["idGerado"]  = mysqli_insert_id($conexao);
            }else{
                $vetorDeResposta["resultado"] = "Não foi possível inserir os dados";
                $vetorDeResposta["idGerado"]  = "";
            }
            echo json_encode($vetorDeResposta);

        }else if ($acao=="update"){
            $sql = "update jogador set nome ='{$nome}', email ='{$email}', pontuacao ={$pontuacao}, senha ='{$senha}' where id={$id} ";
            
            mysqli_query($conexao, $sql);
            $linhas_afetadas = mysqli_affected_rows($conexao);
            $vetorDeResposta = array();
            if ($linhas_afetadas>0) {
                $vetorDeResposta["resultado"] = "Dados atualizados com sucesso!";
            }else{
                $vetorDeResposta["resultado"] = "Nenhum dado foi alterado!";
            }
            echo json_encode($vetorDeResposta);

        }else if ($acao=="delete"){
            $sql="delete from jogador where id={$id}";
            mysqli_query($conexao, $sql);
            $linhas_afetadas = mysqli_affected_rows($conexao);
            $vetorDeResposta = array();
            if ($linhas_afetadas>0) {
                $vetorDeResposta["resultado"] = "Dados excluídos com sucesso!";
            }else{
                $vetorDeResposta["resultado"] = "Não foi possível excluir os dados";
            }
            echo json_encode($vetorDeResposta);
        }

    }catch(Exception $e){
        $vetorDeResposta = array();
        $vetorDeResposta["resultado"]       = "Ocorreu o seguinte erro: ".$e->getMessage();
        echo json_encode($vetorDeResposta);

    }finally{
        mysqli_close($conexao);    
    }

?>