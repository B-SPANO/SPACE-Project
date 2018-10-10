CREATE DATABASE IF NOT EXISTS `spacetest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: USER
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS  `USER` (
        `user_id`    Int  Auto_increment  NOT NULL ,
        `user_login` Varchar (75) NOT NULL ,
        `user_pwd`   Varchar (255) NOT NULL ,
        `user_mail`  Varchar (75) NOT NULL,
        PRIMARY KEY (`user_id`)
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: DECK
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS  `DECK` (
        `deck_id`      Int  Auto_increment  NOT NULL ,
        `deck_libelle` Varchar (50) NOT NULL ,
        `deck_maxcard` Int NOT NULL ,
        `deck_hero`    Int NOT NULL ,
        `user_id`     Int NOT NULL,
        PRIMARY KEY (`deck_id`),
    CONSTRAINT `d_user_fk` FOREIGN KEY (`user_id`) REFERENCES `USER`(`user_id`) ON UPDATE CASCADE ON DELETE RESTRICT 
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: HERO
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS  `HERO` (
        `hero_id`      Int  Auto_increment  NOT NULL ,
        `hero_libelle` Varchar (75) NOT NULL ,
        `hero_hpmax`   TinyINT NOT NULL,
        PRIMARY KEY (`hero_id`)
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: card
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `CARD` (
        `card_id`          Int  Auto_increment  NOT NULL ,
        `card_libelle`     Varchar (25) NOT NULL ,
        `card_template`    Varchar (255) NOT NULL ,
        `card_image`       Varchar (255) NOT NULL ,
        `card_description` Varchar (80) NOT NULL ,
        `card_mana`        Int NOT NULL ,
        `card_power`       Int NOT NULL ,
        `card_hp`          Int NOT NULL ,
        `card_type`        Varchar (25) NOT NULL ,
        `card_copymax`     TinyINT NOT NULL ,
        `hero_id`          Int NOT NULL,
        PRIMARY KEY (`card_id`),
    CONSTRAINT `c_hero_fk` FOREIGN KEY (`hero_id`) REFERENCES `HERO`(`hero_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: ABILITIES
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ABILITIES` (
        `abil_id`          Int  Auto_increment  NOT NULL ,
        `abil_libelle`     Varchar (50) NOT NULL ,
        `abil_description` Mediumtext NOT NULL,
        PRIMARY KEY (`abil_id`)
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: GAME
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `GAME` (
        `game_id`     Int  Auto_increment  NOT NULL ,
        `game_statut` Bool NOT NULL COMMENT "1 : Game active  0 : Game terminated",
        PRIMARY KEY (`game_id`)
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: GAME_HERO
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `GAME_HERO` (
        `ghero_id`    Int  Auto_increment  NOT NULL ,
        `ghero_hpmax` TinyINT NOT NULL ,
        `hero_id`     Int NOT NULL,
        PRIMARY KEY (`ghero_id`),
    CONSTRAINT `g_hero_fk` FOREIGN KEY (`hero_id`) REFERENCES `HERO`(`hero_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: PLAYER
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `PLAYER` (
        `play_id`  Int  Auto_increment  NOT NULL ,
        `ghero_id` Int NOT NULL ,
        `game_id`  Int NOT NULL ,
        `user_id`  Int NOT NULL,
        PRIMARY KEY (`play_id`),
    CONSTRAINT `p_ghero_fk`	FOREIGN KEY (`ghero_id`) REFERENCES `GAME_HERO`(`ghero_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `p_game_fk` FOREIGN KEY (`game_id`) REFERENCES `GAME`(`game_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `p_user_fk` FOREIGN KEY (`user_id`) REFERENCES `USER`(`user_id`) ON UPDATE CASCADE ON DELETE RESTRICT

)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: HAVE
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `HAVE` (
        `abil_id` Int NOT NULL ,
        `card_id` Int NOT NULL,
        PRIMARY KEY (`abil_id`, `card_id`),
    CONSTRAINT `h_abilities_fk`	FOREIGN KEY (`abil_id`) REFERENCES `ABILITIES`(`abil_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `h_card_fk` FOREIGN KEY (`card_id`) REFERENCES `CARD`(`card_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: IS COMPOSED BY
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `IS_COMPOSED_BY`(
        `card_id` Int NOT NULL ,
        `deck_id` Int NOT NULL,
        PRIMARY KEY (`card_id`, `deck_id`),
    CONSTRAINT `icb_card_fk` FOREIGN KEY (`card_id`) REFERENCES `CARD`(`card_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `icb_deck_fk` FOREIGN KEY (`deck_id`) REFERENCES `DECK`(`deck_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: GAME_CARD
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `GAME_CARD` (
        `gcard_id`           Int  Auto_increment  NOT NULL ,
        `gcard_hp`           Int NOT NULL ,
        `gcard_sleep`        Bool NOT NULL ,
        `gcard_power`        Int NOT NULL ,
        `moment`             Datetime NOT NULL ,
        `damages`            Int NOT NULL ,
        `play_id`            Int NOT NULL ,
        `card_id`            Int NOT NULL ,
        `gcard_id_GAME_CARD` Int NOT NULL,
        PRIMARY KEY (`gcard_id`),
    CONSTRAINT `gc_player_fk` FOREIGN KEY (`play_id`) REFERENCES `PLAYER`(`play_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `gc_card_FK` FOREIGN KEY (`card_id`)	REFERENCES `CARD`(`card_id`) ON UPDATE CASCADE ON DELETE RESTRICT
    )ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: SUMMON
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS  `SUMMON` (
        `gcard_id` Int NOT NULL ,
        `play_id`  Int NOT NULL ,
        `moment`   Datetime NOT NULL,
        PRIMARY KEY (`gcard_id`, `play_id`),
    CONSTRAINT `s_gcard_fk` FOREIGN KEY (`gcard_id`) REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `s_player_fr` FOREIGN KEY (`play_id`) REFERENCES `PLAYER`(`play_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: DRAW
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `DRAW`(
        `gcard_id` Int NOT NULL ,
        `play_id`  Int NOT NULL ,
        `moment`   Datetime NOT NULL
	, PRIMARY KEY (`gcard_id`, `play_id`),
    CONSTRAINT `d_gcard_fk` FOREIGN KEY (`gcard_id`) REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `d_player_fk` FOREIGN KEY (`play_id`) REFERENCES `PLAYER`(`play_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# Table: _ATTACK
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `_ATTACK` (
        `ghero_id` Int NOT NULL ,
        `gcard_id` Int NOT NULL ,
        `moment`   Datetime NOT NULL ,
        `damages`  Int NOT NULL,
        PRIMARY KEY (`ghero_id`, `gcard_id`),
    CONSTRAINT `_a_ghero_fk` FOREIGN KEY (`ghero_id`) REFERENCES `GAME_HERO`(`ghero_id`) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT `_a_gcard_fk` FOREIGN KEY (`gcard_id`) REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT
)ENGINE=InnoDB CHARSET=utf8mb4;


#------------------------------------------------------------
# ALTER TABLE :
#------------------------------------------------------------

-- ALTER TABLE `DECK`
-- 	ADD CONSTRAINT `d_user_fk`
-- 	FOREIGN KEY (`user_id`)
-- 	REFERENCES `USER`(`user_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `CARD`
-- 	ADD CONSTRAINT `c_hero_fk`
-- 	FOREIGN KEY (`hero_id`)
-- 	REFERENCES `HERO`(`hero_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `GAME_HERO`
-- 	ADD CONSTRAINT `g_hero_fk`
-- 	FOREIGN KEY (`hero_id`)
-- 	REFERENCES `HERO`(`hero_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `PLAYER`
-- 	ADD CONSTRAINT `p_ghero_fk`
-- 	FOREIGN KEY (`ghero_id`)
-- 	REFERENCES `GAME_HERO`(`ghero_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `PLAYER`
-- 	ADD CONSTRAINT `p_game_fk`
-- 	FOREIGN KEY (`game_id`)
-- 	REFERENCES `GAME`(`game_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `PLAYER`
-- 	ADD CONSTRAINT `p_user_fk`
-- 	FOREIGN KEY (`user_id`)
-- 	REFERENCES `USER`(`user_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `HAVE`
-- 	ADD CONSTRAINT `h_abilities_fk`
-- 	FOREIGN KEY (`abil_id`)
-- 	REFERENCES `ABILITIES`(`abil_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `HAVE`
-- 	ADD CONSTRAINT `h_card_fk`
-- 	FOREIGN KEY (`card_id`)
-- 	REFERENCES `CARD`(`card_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `IS_COMPOSED_BY`
-- 	ADD CONSTRAINT `icb_card_fk`
-- 	FOREIGN KEY (`card_id`)
-- 	REFERENCES card(`card_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `IS_COMPOSED_BY`
-- 	ADD CONSTRAINT `icb_deck_fk`
-- 	FOREIGN KEY (`deck_id`)
-- 	REFERENCES `DECK`(`deck_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `GAME_CARD`
-- 	ADD CONSTRAINT `gc_player_fk`
-- 	FOREIGN KEY (`play_id`)
-- 	REFERENCES `PLAYER`(`play_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `GAME_CARD`
-- 	ADD CONSTRAINT `gc_card_FK`
-- 	FOREIGN KEY (`card_id`)
-- 	REFERENCES `CARD`(`card_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `GAME_CARD`
-- 	ADD CONSTRAINT `gc_gcard_fk`
-- 	FOREIGN KEY (`gcard_id_GAME_CARD`)
-- 	REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `SUMMON`
-- 	ADD CONSTRAINT `s_gcard_fk`
-- 	FOREIGN KEY (`gcard_id`)
-- 	REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `SUMMON`
-- 	ADD CONSTRAINT `s_player_fr`
-- 	FOREIGN KEY (`play_id`)
-- 	REFERENCES `PLAYER`(`play_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `DRAW`
-- 	ADD CONSTRAINT `d_gcard_fk`
-- 	FOREIGN KEY (`gcard_id`)
-- 	REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `DRAW`
-- 	ADD CONSTRAINT `d_player_fk`
-- 	FOREIGN KEY (`play_id`)
-- 	REFERENCES `PLAYER`(`play_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `_ATTACK`
-- 	ADD CONSTRAINT `_a_ghero_fk`
-- 	FOREIGN KEY (`ghero_id`)
-- 	REFERENCES `GAME_HERO`(`ghero_id`) ON UPDATE CASCADE ON DELETE RESTRICT;

-- ALTER TABLE `_ATTACK`
-- 	ADD CONSTRAINT `_a_gcard_fk`
-- 	FOREIGN KEY (`gcard_id`)
-- 	REFERENCES `GAME_CARD`(`gcard_id`) ON UPDATE CASCADE ON DELETE RESTRICT;
