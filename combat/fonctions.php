<?php 
/**
 * Initialising Board
 *
 * @return array
 */
function set_board(){
    $boardPlayer1 = array();
    return $boardPlayer1;
}

/**
 * create Deck's playable instance
 *
 * @param array $deckAstro
 * @return array $playableDeck
 */
function init_deck($deckAstro){
    shuffle($deckAstro);
    $playableDeck = $deckAstro;
    return $playableDeck;
}

/**
 * Turn incrementation
 *
 * @param [int] $turnPlayer1
 * @return [int] $turnPlayer1
 */
function end_turn($turnPlayer1){
        $turnPlayer1 += 1;
        return $turnPlayer1;
}

/**
 * Draw function for first and later turn
 *
 * @param [type] $playableDeck
 * @param [type] $turnPlayer1
 * @return void
 */
function draw(&$playableDeck, $turnPlayer1){
    shuffle($playableDeck);
    if ($turnPlayer1 == 0){
        for ($i=0; $i < 3; $i++){ 
            $handPlayer1[] =  $playableDeck[$i];
            unset($playableDeck[$i]);
        }
    }
    else {
        if ($playableDeck <= 0) {
            // faire les try catch raise au cas ou le deck est vide
        }
        for ($i=0; $i < 1; $i++) { 
            $handPlayer1[] = $playableDeck[$i];
            unset($playableDeck[$i]);
        }
    }
    return $handPlayer1;
}


/**
 * Incremental function for Mana Max by turn
 *
 * @param [type] $turnPlayer1
 * @return void
 */
function mana_max($turnPlayer1){
    if ($turnPlayer1 >= 10) {
        $manaByTurn = 10;
    }
    else{
        $manaByTurn = $turnPlayer1 + 1;
    }
    return $manaByTurn;
}

/**
 * Card Mana Cost
 *
 * @param array $Card
 * @return int $manaCost
 */
function mana_cost($Card){
    foreach ($Card as $key => $value) {
        $manaCost = $value['mana'];
    }
    return $manaCost;
}
