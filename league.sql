 DROP DATABASE IF EXISTS `league`;
CREATE DATABASE `league`;
USE `league`;

CREATE TABLE Country (
    c_name VARCHAR(64) PRIMARY KEY,
    leagues_hosted INT
);

CREATE TABLE Referee (
    ref_id INT PRIMARY KEY AUTO_INCREMENT,
    age int,
    name VARCHAR(64) not null,
    games_reffed INT
);

CREATE TABLE Stadium (
    stadium_id INT PRIMARY KEY AUTO_INCREMENT,
    stadium_name varchar(64) not null,
    seats INT,
    founded DATE
);

CREATE TABLE Manager (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(64) not null,
    age int,
    years_managing INT,
    titles_managed INT
);

CREATE TABLE League (
    league_name VARCHAR(64) PRIMARY KEY,
    country_name VARCHAR(64),
    founded DATE,
    total_teams INT,
    total_games INT,
    FOREIGN KEY (country_name) REFERENCES Country(c_name) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Team (
    t_name VARCHAR(64) PRIMARY KEY,
    manager_id INT,
    nationality VARCHAR(64),
    founded DATE,
    total_titles INT,
    historical_performance INT,
    home_stadium INT,
    league_name VARCHAR(64),
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (nationality) REFERENCES Country(c_name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (home_stadium) REFERENCES Stadium(stadium_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (league_name) REFERENCES League(league_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Odds (
    odds_id INT PRIMARY KEY,
    under_odds INT,
    over_odds INT
);

CREATE TABLE `Match` (    
    match_id INT PRIMARY KEY auto_increment,
    ref INT,
    game_date DATE,
    venue INT not null,
    home VARCHAR(64) not null,
    away VARCHAR(64) not null,
    scoreline VARCHAR(64) not null,
    attendance INT,
    odds_id INT,
    league varchar(64),
    FOREIGN KEY (home) REFERENCES Team(t_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (away) REFERENCES Team(t_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (venue) REFERENCES Stadium(stadium_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (odds_id) REFERENCES Odds(odds_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (league) REFERENCES League(league_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ref) REFERENCES Referee(ref_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Stats (
    stats_id INT PRIMARY KEY AUTO_INCREMENT,
    goals INT DEFAULT 0,
    appearances INT DEFAULT 0,
    assists INT DEFAULT 0
);

CREATE TABLE Player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    p_name VARCHAR(64) not null, 
    nationality VARCHAR(64), 
    position VARCHAR(64), 
    age INT, 
    team_name VARCHAR(64),
    player_stats INT UNIQUE,
    FOREIGN KEY (team_name) REFERENCES Team(t_name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (nationality) REFERENCES Country(c_name) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (player_stats) REFERENCES Stats(stats_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Event (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    player_involved INT,
    description VARCHAR(64),
    event_type ENUM ("Goals", "Cards", "Substitutions") not null,
    minute INT,
    FOREIGN KEY (match_id) REFERENCES `Match`(match_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	  FOREIGN KEY (player_involved) REFERENCES Player(player_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Assist (
    assist_id INT PRIMARY KEY AUTO_INCREMENT,
    assisting_player INT,
    goal INT,
    FOREIGN KEY (assisting_player) REFERENCES Player(player_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (goal) REFERENCES Event(event_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- This is when a player gets deleted delete a player's stats
DELIMITER //
CREATE TRIGGER delete_player_stats
AFTER DELETE ON Player
FOR EACH ROW
BEGIN
    DELETE FROM stats WHERE stats_id = OLD.player_stats;
END;
//
DELIMITER ;
DELIMITER //
-- This is when a match gets deleted delete it's odds.
CREATE TRIGGER delete_match_odds
AFTER DELETE ON `Match`
FOR EACH ROW
BEGIN
    DELETE FROM odds WHERE odds_id = OLD.odds_id;
END;
//
DELIMITER ;
-- This is when a new league gets made update the country's new league hosted.
DELIMITER //
CREATE TRIGGER update_leagues_hosted
AFTER INSERT ON League
FOR EACH ROW
BEGIN
    UPDATE Country
    SET leagues_hosted = leagues_hosted + 1
    where c_name = NEW.country_name;
END;
//
DELIMITER ;
-- This is when a new game_match gets added update the league's game counts.
DELIMITER //
CREATE TRIGGER update_leagues_games
AFTER INSERT ON `Match`
FOR EACH ROW
BEGIN
    UPDATE League
    SET total_games = total_games + 1
    where league_name = NEW.league;
END;

//
DELIMITER ;
-- This is when a new teams gets added update the league's team count.
DELIMITER //
CREATE TRIGGER update_leagues_teams
AFTER INSERT ON Team
FOR EACH ROW
BEGIN
    UPDATE League
    SET total_teams = total_teams + 1
    where league_name = NEW.league_name;
END;
//
DELIMITER ;
-- When a team wins a title add it to the manager's titles managed count.
DELIMITER //
CREATE TRIGGER update_manager_total_titles
AFTER UPDATE ON Team
FOR EACH ROW
BEGIN
    UPDATE Manager
    SET titles_managed = titles_managed + (NEW.total_titles - OLD.total_titles)
    WHERE manager_id = NEW.manager_id;
END;
//
DELIMITER ;

-- When a game_match adds a ref 
DELIMITER //
CREATE TRIGGER update_ref_games
AFTER INSERT ON `Match`
FOR EACH ROW
BEGIN
    UPDATE Referee
    SET games_reffed = games_reffed + 1
    where ref_id = NEW.ref;
END;
//
DELIMITER ;