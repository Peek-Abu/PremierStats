DROP DATABASE IF EXISTS `league`;
CREATE DATABASE `league`;
USE `league`;

CREATE TABLE Country (
    c_name VARCHAR(64) PRIMARY KEY,
    leagues_hosted INT
);

CREATE TABLE Referee (
    ref_id INT PRIMARY KEY,
    age int,
    name VARCHAR(64),
    games_reffed INT
);

CREATE TABLE Stadium (
    stadium_id INT PRIMARY KEY,
    seats INT,
    founded DATE
);

CREATE TABLE Manager (
    manager_id INT PRIMARY KEY,
    name varchar(64),
    age int,
    years_managing INT,
    titles_managed INT
);

CREATE TABLE Team (
    t_name VARCHAR(64) PRIMARY KEY,
    manager INT,
    nationality VARCHAR(64),
    founded DATE,
    total_titles INT,
    historical_performance INT,
    FOREIGN KEY (manager) REFERENCES Manager(manager_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (nationality) REFERENCES Country(c_name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Odds (
    odds_id INT PRIMARY KEY,
    under_odds INT,
    over_odds INT
);

CREATE TABLE Game_Match (    
    match_id INT PRIMARY KEY,
    ref INT,
    game_date DATE,
    venue INT,
    home VARCHAR(64),
    away VARCHAR(64),
    scoreline VARCHAR(64),
    attendance INT,
    odds INT,
    FOREIGN KEY (home) REFERENCES Team(t_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (away) REFERENCES Team(t_name) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (venue) REFERENCES Stadium(stadium_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (odds) REFERENCES Odds(odds_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ref) REFERENCES Referee(ref_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Stats (
	stats_id int primary key,
    goals INT,
    appearances INT,
    assists INT
);

CREATE TABLE Player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    p_name VARCHAR(64), 
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
    event_id INT PRIMARY KEY,
    match_id INT,
    player_involved INT,
    description VARCHAR(64),
    event_type ENUM ("Goals", "Cards", "Substitutions"),
    FOREIGN KEY (match_id) REFERENCES Game_Match(match_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Assist (
    assist_id INT PRIMARY KEY,
    assisting_player INT,
    goal INT,
    FOREIGN KEY (assisting_player) REFERENCES Player(player_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (goal) REFERENCES Event(event_id) ON DELETE RESTRICT ON UPDATE CASCADE
);




