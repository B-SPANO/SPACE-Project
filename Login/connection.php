<?php
session_start();
require("ini.php");
require("functions.php");


if(isset($_GET['destroy'])){
    session_destroy;
    header('location:espace_membre.php');
    exit;
}


// TEST A FAIRE:
//--------------
// Verifier presence Login / mail ds BDD -> DONE
// Verifier intégriter email -> DONE
// Verifier correlation password / password -> DONE


// TO DO:
//-------
// redirection apres login;


if(isset($_POST['login']) && isset($_POST['password'])){
    if(CheckLogin($_POST['login']) && CheckPassword($_POST['password'])){
        $_SESSION['login'] = $_POST['login'];
        echo('Bienvenu(e) ' . $_SESSION['login']);
    }else{
        $alert = "Votre couple identifiant / Mot de passe ne correspond pas.";
    } 
}     

if(isset($_POST['login'], $_POST['mail'], $_POST['password'], $_POST['password2'])){
    if(CheckInscriptionLogin($_POST['login']) !== true){
        if(filter_var($_POST['mail'], FILTER_VALIDATE_EMAIL)) {
            if(CheckInscriptionMail($_POST['mail']) !== true){
                if(CheckInscriptionPassword($_POST['password'], $_POST['password2']) !==false ){     
                    try{
                        $db = new PDO($dsn, $user, $pwd, array(PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION));
                        if($requete = $db->prepare('INSERT INTO `user` VALUES (NULL, :login, :password, :mail)')){
                            if($requete->bindValue('login', $_POST['login']) && $requete->bindValue('password', $_POST['password']) && $requete->bindValue('mail', $_POST['mail'])){
                                $reponse = $requete->execute();
                                $requete->closeCursor();
                            }
                            else {
                                die('Problème lors du lien');
                            }
                        }
                        else {
                            die('Problème lors de la préparation');
                        }
                    } catch(PDOEXCEPTION $e){
                        die($e->getMessage());
                    }
                }else{
                    $alert = "Votre password n'est pas identique dans les deux champs de saisie.";
                }
            }else{
                $alert = "Cette adresse email est déjà utilisée.";
            }
        }else{
            $alert = "Le format de l'adresse e-mail n'est pas valide";
        }     
    }else{
        $alert = "Ce nom d'utilisateur est déjà utilisé.";
    }
}


if (!empty($reponse)){
    $_Session['status'] = "Votre Inscription a été validée, Vous pouvez maintenant vous connecter.";

}
if (isset($alert)){
    echo $alert;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SPACE</title>
</head>
<body>

    
    
    <form action="" method="GET">
        <input type="submit" value="Sign Up" name="inscription">
    </form>
    <?php 
        if(isset($_GET['inscription'])){
            echo('<form action="" method="POST">
                <h2>Inscription:</h2>
                <p>Veuillez saisir votre nom d utilisateur:</p>
                <input type="text" name="login" placeholder="Login">
                <p>Veuillez saisir votre adresse e-mail:</p>
                <input type="text" name="mail" placeholder="e-mail">
                <p>Veuillez saisir votre Mot de passe:</p>
                <input type="password" name="password" placeholder="Password">
                <p>Veuillez re-saisir votre Mot de passe:</p>
                <input type="password" name="password2" placeholder="Password">
                <br><br>
                <button type="submit">Inscription</button>
                </form>');
            if(isset($alert)){
                echo('<p>' . $alert . '</p>');
            }
            if(isset($_SESSION['status'])){
                header('location:connection.php?');
                exit;
            }
        }
    ?>

    
        
              
    <form action="" method="POST" <?php if(isset($_GET['inscription']))echo(' style="display: none">')?> >
    <h2>Connection:</h2>
    <p>Veuillez saisir votre nom d\'utilisateur:</p>
    <input type="text" name="login" placeholder="Login">
    <p>Veuillez saisir votre Mot de passe:</p>
    <input type="password" name="password" placeholder="Password">
    <br><br>
    <button type="submit">Valider</button>
    </form>

    <?php if(isset($statut)){
        echo('<p>' . $_SESSION['statut'] . '</p>');
    }?>
    

</body>
</html>