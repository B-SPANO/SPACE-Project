<?php
session_start();
include 'ini.php';
include 'fonctions.php';

if(isset($_GET['destroy'])){
    unset($_SESSION['game']);
    header('Location:http://localhost/www/SPACE/');
    exit;
}

// Initialisation
if (!isset($_SESSION['game']['handPlayer1'])){

    $_SESSION['game']['handPlayer1'] = [];
}
//Creating Deck playable instance
if(!isset($_SESSION['game']['playableDeck'])){
    $_SESSION['game']['playableDeck'] = init_deck($deckAstro);
}

// Initialisation Game Board
$_SESSION['game']['boardPlayer1'] = set_board();

// Initialisation Turn
if (!isset($_POST['end_turn'])) {
    $_SESSION['game']['turnPlayer1'] = 0;
}
else{
    $_SESSION['game']['turnPlayer1'] = end_turn($_SESSION['game']['turnPlayer1']);
}


// Initialisation Mana Max by turn
$_SESSION['game']['manaByTurn'] = mana_max($_SESSION['game']['turnPlayer1']);

// Initialising and filling cards in player hand
$_SESSION['game']['handPlayer1'] = array_merge($_SESSION['game']['handPlayer1'], draw($_SESSION['game']['playableDeck'], $_SESSION['game']['turnPlayer1']));





//  EN COURS: LE BOARD ET LA POSE DES CARTES AVEC LE COUT EN MANA.

foreach ($_SESSION['game']['handPlayer1'] as $key => $value) {
    $handplayer = $value;
    var_dump($handplayer);
}


//  A FAIRE: LA GESTION D'ATTAQUE SIMPLE.
//  A FAIRE: LA GESTION DES CARTES BOUCLIERS ET LES MECANIQUES DES CARTES SORTS.


?>

<html>
    <section class="player1">
        <p>Board:<?php  ?></p>
        <p>Deck:<?php echo(count($_SESSION['game']['playableDeck'])); ?></p>
        <p>Carte en Main: <?php var_dump($_SESSION['game']['handPlayer1'])?></p>
        <p>Mana: <?php echo($_SESSION['game']['manaByTurn']); ?></p>
        <form action="#" method="POST">
            <input type="submit" name="end_turn" value="Fin du Tour">
        </form>
        <a href="?destroy">KILL THEM ALL</a>
    </section>
    
    <section class="player2">

    </section>
</html>