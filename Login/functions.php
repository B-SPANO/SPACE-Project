<?php
require('ini.php');

function CheckInscriptionLogin($login){
    $dsn = 'mysql:host=127.0.0.1;dbname=spacetest;charset=utf8mb4';
    $user = 'root';
    $pwd = '';
    try{
        $db = new PDO($dsn, $user, $pwd, array(PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION));
        if(($requete = $db->prepare('SELECT `user_login` FROM `user` WHERE `user_login`=:login')) !==false ){
            if($requete->bindValue('login',$_POST['login']) ){
                if( $requete->execute() ){
                    $reponse = $requete->fetch(PDO::FETCH_ASSOC);
                    $requete->closeCursor();
                    if($reponse!==false) {
                        return true;
                    }
                }
            }
        }
        return false;
    }catch(PDOEXCEPTION $e){
        die($e->getMessage());
    }
}

function CheckInscriptionMail($mail){
    $dsn = 'mysql:host=127.0.0.1;dbname=spacetest;charset=utf8mb4';
    $user = 'root';
    $pwd = '';
    try{
        $db = new PDO($dsn, $user, $pwd, array(PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION));
        if(($requete = $db->prepare('SELECT `user_mail` FROM `user` WHERE `user_mail`=:mail')) !==false ){
            if($requete->bindValue('mail',$_POST['mail']) ){
                if( $requete->execute() ){
                    $reponse = $requete->fetch(PDO::FETCH_ASSOC);
                    $requete->closeCursor();
                    if($reponse!==false) {
                        return true;
                    }
                }
            }
        }
        return false;
    }catch(PDOEXCEPTION $e){
        die($e->getMessage());
    }
}

function CheckInscriptionPassword($password, $password2){
    if($password == $password2){
        return true;
    }else{
        return false;
    }
}

function CheckLogin($login){
    $dsn = 'mysql:host=127.0.0.1;dbname=spacetest;charset=utf8mb4';
    $user = 'root';
    $pwd = '';
    try{
        $db = new PDO($dsn, $user, $pwd, array(PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION));
        if(($requete = $db->prepare('SELECT `user_login` FROM `user` WHERE `user_login`=:login')) !==false ){
            if($requete->bindValue('login',$_POST['login']) ){
                if( $requete->execute() ){
                    $reponse = $requete->fetch(PDO::FETCH_ASSOC);
                    $requete->closeCursor();
                    if($reponse!==false) {
                        return true;
                    }
                }
            }
        }
        return false;
    }catch(PDOEXCEPTION $e){
        die($e->getMessage());
    }
}

function CheckPassword($password){
    $dsn = 'mysql:host=127.0.0.1;dbname=spacetest;charset=utf8mb4';
    $user = 'root';
    $pwd = '';
    try{
        $db = new PDO($dsn, $user, $pwd, array(PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION));
        if(($requete = $db->prepare('SELECT `user_pwd` FROM `user` WHERE `user_pwd`=:pwd')) !==false ){
            if($requete->bindValue('pwd',$_POST['password']) ){
                if( $requete->execute() ){
                    $reponse = $requete->fetch(PDO::FETCH_ASSOC);
                    $requete->closeCursor();
                    if($reponse!==false) {
                        return true;
                    }
                }
            }
        }
        return false;
    }catch(PDOEXCEPTION $e){
        die($e->getMessage());
    }
}
