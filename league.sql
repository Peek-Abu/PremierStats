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
    league varchar(64) not null,
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
    match_id INT not null,
    player_involved INT not null,
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
    SET leagues_hosted = leagues_hosted + 1;
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


INSERT INTO Event (match_id, player_involved, description, event_type, minute) VALUES
-- Chelsea vs Everton
(1, 1, 'Goal', 'Goals', 20),
(1, 2, 'Goal', 'Goals', 50),
(1, 2, 'Goal', 'Goals', 70),
(1, 2, 'Yellow Card', 'Cards', 30),
(1, 2, 'Substitution', 'Substitutions', 60),
(1, 1, 'Substitution', 'Substitutions', 75),

-- Everton vs Chelsea
(2, 5, 'Goal', 'Goals', 60),
(2, 6, 'Goal', 'Goals', 80),
(2, 6, 'Goal', 'Goals', 85),
(2, 6, 'Yellow Card', 'Cards', 40),
(2, 6, 'Substitution', 'Substitutions', 65),
(2, 5, 'Substitution', 'Substitutions', 70),

-- Athletic Bilbao vs Real Betis
(3, 3, 'Goal', 'Goals', 35),
(3, 4, 'Goal', 'Goals', 55),
(3, 4, 'Goal', 'Goals', 75),
(3, 4, 'Yellow Card', 'Cards', 60),
(3, 3, 'Substitution', 'Substitutions', 70),
(3, 3, 'Substitution', 'Substitutions', 80),

-- Real Betis vs Athletic Bilbao
(4, 7, 'Goal', 'Goals', 45),
(4, 7, 'Goal', 'Goals', 65),
(4, 7, 'Goal', 'Goals', 90),
(4, 7, 'Red Card', 'Cards', 70),
(4, 7, 'Substitution', 'Substitutions', 75),
(4, 7, 'Substitution', 'Substitutions', 80),

-- Chelsea vs Athletic Bilbao
(5, 1, 'Goal', 'Goals', 10),
(5, 2, 'Goal', 'Goals', 40),
(5, 2, 'Goal', 'Goals', 85),
(5, 2, 'Yellow Card', 'Cards', 20),
(5, 2, 'Substitution', 'Substitutions', 65),
(5, 1, 'Substitution', 'Substitutions', 70),

-- Athletic Bilbao vs Chelsea
(6, 3, 'Goal', 'Goals', 25),
(6, 4, 'Goal', 'Goals', 60),
(6, 3, 'Goal', 'Goals', 90),
(6, 4, 'Yellow Card', 'Cards', 50),
(6, 3, 'Substitution', 'Substitutions', 70),
(6, 3, 'Substitution', 'Substitutions', 80),

-- Everton vs Real Betis
(7, 5, 'Goal', 'Goals', 15),
(7, 5, 'Goal', 'Goals', 55),
(7, 5, 'Goal', 'Goals', 90),
(7, 5, 'Red Card', 'Cards', 80),
(7, 5, 'Substitution', 'Substitutions', 65),
(7, 5, 'Substitution', 'Substitutions', 70),

-- Real Betis vs Everton
(8, 7, 'Goal', 'Goals', 30),
(8, 7, 'Goal', 'Goals', 75),
(8, 7, 'Goal', 'Goals', 90),
(8, 7, 'Yellow Card', 'Cards', 60),
(8, 7, 'Substitution', 'Substitutions', 65),
(8, 7, 'Substitution', 'Substitutions', 70),

-- Chelsea vs Everton
(9, 1, 'Goal', 'Goals', 20),
(9, 2, 'Goal', 'Goals', 40),
(9, 2, 'Goal', 'Goals', 70),
(9, 2, 'Yellow Card', 'Cards', 30),
(9, 2, 'Substitution', 'Substitutions', 65),
(9, 1, 'Substitution', 'Substitutions', 70),

-- Everton vs Chelsea
(10, 5, 'Goal', 'Goals', 15),
(10, 6, 'Goal', 'Goals', 35),
(10, 6, 'Goal', 'Goals', 85),
(10, 6, 'Yellow Card', 'Cards', 40),
(10, 6, 'Substitution', 'Substitutions', 65),
(10, 5, 'Substitution', 'Substitutions', 70),

-- Athletic Bilbao vs Real Betis
(11, 3, 'Goal', 'Goals', 25),
(11, 4, 'Goal', 'Goals', 50),
(11, 4, 'Goal', 'Goals', 75),
(11, 4, 'Yellow Card', 'Cards', 55),
(11, 3, 'Substitution', 'Substitutions', 65),
(11, 3, 'Substitution', 'Substitutions', 70),

-- Real Betis vs Athletic Bilbao
(12, 7, 'Goal', 'Goals', 35),
(12, 7, 'Goal', 'Goals', 60),
(12, 7, 'Goal', 'Goals', 90),
(12, 7, 'Red Card', 'Cards', 70),
(12, 7, 'Substitution', 'Substitutions', 75),
(12, 7, 'Substitution', 'Substitutions', 80),

-- Chelsea vs Athletic Bilbao
(13, 1, 'Goal', 'Goals', 10),
(13, 2, 'Goal', 'Goals', 40),
(13, 2, 'Goal', 'Goals', 85),
(13, 2, 'Yellow Card', 'Cards', 20),
(13, 2, 'Substitution', 'Substitutions', 65),
(13, 1, 'Substitution', 'Substitutions', 70),

-- Athletic Bilbao vs Chelsea
(14, 3, 'Goal', 'Goals', 25),
(14, 4, 'Goal', 'Goals', 60),
(14, 3, 'Goal', 'Goals', 90),
(14, 4, 'Yellow Card', 'Cards', 50),
(14, 3, 'Substitution', 'Substitutions', 70),
(14, 3, 'Substitution', 'Substitutions', 80);


-- Chelsea vs Everton
INSERT INTO Assist (assisting_player, goal) VALUES
(1, 2),  -- Mason Mount's goal, Timo Werner as assister
(2, 1),  -- Timo Werner's goal, Mason Mount as assister
(2, 1),  -- Timo Werner's goal, Mason Mount as assister
(5, 6),  -- Dominic Calvert-Lewin's goal, Richarlison as assister
(5, 6),  -- Dominic Calvert-Lewin's goal, Richarlison as assister

-- Everton vs Chelsea
(5, 16), -- Inaki Williams' goal, Mason Mount as assister
(6, 16), -- Mason Mount's goal, Inaki Williams as assister
(6, 16), -- Mason Mount's goal, Inaki Williams as assister
(7, 46), -- Sergio Canales' goal, Nabil Fekir as assister
(7, 46), -- Sergio Canales' goal, Nabil Fekir as assister

-- Athletic Bilbao vs Real Betis
(3, 26), -- Inaki Williams' goal, Iker Muniain as assister
(4, 26), -- Iker Muniain's goal, Inaki Williams as assister
(4, 26), -- Iker Muniain's goal, Inaki Williams as assister
(7, 32), -- Nabil Fekir's goal, Sergio Canales as assister
(7, 32), -- Nabil Fekir's goal, Sergio Canales as assister

-- Real Betis vs Athletic Bilbao
(7, 40), -- Sergio Canales' goal, Nabil Fekir as assister
(7, 40), -- Sergio Canales' goal, Nabil Fekir as assister
(7, 40), -- Sergio Canales' goal, Nabil Fekir as assister
(7, 80), -- Nabil Fekir's goal, Sergio Canales as assister
(7, 80), -- Nabil Fekir's goal, Sergio Canales as assister

-- Chelsea vs Athletic Bilbao
(5, 34), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 34), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 34), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(7, 44), -- Nabil Fekir's goal, Sergio Canales as assister
(7, 44), -- Nabil Fekir's goal, Sergio Canales as assister

-- Athletic Bilbao vs Chelsea
(3, 44), -- Inaki Williams' goal, Iker Muniain as assister
(4, 44), -- Iker Muniain's goal, Inaki Williams as assister
(3, 44), -- Inaki Williams' goal, Iker Muniain as assister
(7, 48), -- Sergio Canales' goal, Nabil Fekir as assister
(7, 48), -- Sergio Canales' goal, Nabil Fekir as assister

-- Everton vs Real Betis
(5, 50), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 50), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 50), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(7, 56), -- Nabil Fekir's goal, Sergio Canales as assister
(7, 56), -- Nabil Fekir's goal, Sergio Canales as assister

-- Real Betis vs Everton
(5, 52), -- Sergio Canales' goal, Nabil Fekir as assister
(5, 52), -- Sergio Canales' goal, Nabil Fekir as assister
(5, 52), -- Sergio Canales' goal, Nabil Fekir as assister
(5, 58), -- Dominic Calvert-Lewin's goal, Richarlison as assister
(5, 58), -- Dominic Calvert-Lewin's goal, Richarlison as assister

-- Chelsea vs Everton
(1, 62), -- Timo Werner's goal, Mason Mount as assister
(2, 62), -- Mason Mount's goal, Timo Werner as assister
(2, 62), -- Mason Mount's goal, Timo Werner as assister
(5, 68), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 68), -- Richarlison's goal, Dominic Calvert-Lewin as assister

-- Everton vs Chelsea
(5, 68), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 68), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(5, 68), -- Richarlison's goal, Dominic Calvert-Lewin as assister
(1, 70), -- Timo Werner's goal, Mason Mount as assister
(2, 70); -- Mason Mount's goal, Timo Werner as assister
