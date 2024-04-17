CREATE DATABASE  IF NOT EXISTS `league` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `league`;
-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: 127.0.0.1    Database: league
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Assist`
--

DROP TABLE IF EXISTS `Assist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assist` (
  `assist_id` int NOT NULL AUTO_INCREMENT,
  `assisting_player` int DEFAULT NULL,
  `goal` int DEFAULT NULL,
  PRIMARY KEY (`assist_id`),
  KEY `assisting_player` (`assisting_player`),
  KEY `goal` (`goal`),
  CONSTRAINT `assist_ibfk_1` FOREIGN KEY (`assisting_player`) REFERENCES `Player` (`player_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `assist_ibfk_2` FOREIGN KEY (`goal`) REFERENCES `Event` (`event_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assist`
--

LOCK TABLES `Assist` WRITE;
/*!40000 ALTER TABLE `Assist` DISABLE KEYS */;
/*!40000 ALTER TABLE `Assist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Country`
--

DROP TABLE IF EXISTS `Country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Country` (
  `c_name` varchar(64) NOT NULL,
  `leagues_hosted` int DEFAULT NULL,
  PRIMARY KEY (`c_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Country`
--

LOCK TABLES `Country` WRITE;
/*!40000 ALTER TABLE `Country` DISABLE KEYS */;
/*!40000 ALTER TABLE `Country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `match_id` int DEFAULT NULL,
  `player_involved` int DEFAULT NULL,
  `description` varchar(64) DEFAULT NULL,
  `event_type` enum('Goals','Cards','Substitutions') NOT NULL,
  `minute` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `match_id` (`match_id`),
  KEY `player_involved` (`player_involved`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `Match` (`match_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`player_involved`) REFERENCES `Player` (`player_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `League`
--

DROP TABLE IF EXISTS `League`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `League` (
  `league_name` varchar(64) NOT NULL,
  `country_name` varchar(64) DEFAULT NULL,
  `founded` date DEFAULT NULL,
  `total_teams` int DEFAULT NULL,
  `total_games` int DEFAULT NULL,
  PRIMARY KEY (`league_name`),
  KEY `country_name` (`country_name`),
  CONSTRAINT `league_ibfk_1` FOREIGN KEY (`country_name`) REFERENCES `Country` (`c_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `League`
--

LOCK TABLES `League` WRITE;
/*!40000 ALTER TABLE `League` DISABLE KEYS */;
/*!40000 ALTER TABLE `League` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_leagues_hosted` AFTER INSERT ON `league` FOR EACH ROW BEGIN
    UPDATE Country
    SET leagues_hosted = leagues_hosted + 1
    where c_name = NEW.country_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Manager`
--

DROP TABLE IF EXISTS `Manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Manager` (
  `manager_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `age` int DEFAULT NULL,
  `years_managing` int DEFAULT NULL,
  `titles_managed` int DEFAULT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manager`
--

LOCK TABLES `Manager` WRITE;
/*!40000 ALTER TABLE `Manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `Manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Match`
--

DROP TABLE IF EXISTS `Match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Match` (
  `match_id` int NOT NULL AUTO_INCREMENT,
  `ref` int DEFAULT NULL,
  `game_date` date DEFAULT NULL,
  `venue` int NOT NULL,
  `home` varchar(64) NOT NULL,
  `away` varchar(64) NOT NULL,
  `scoreline` varchar(64) NOT NULL,
  `attendance` int DEFAULT NULL,
  `odds_id` int DEFAULT NULL,
  `league` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`match_id`),
  KEY `home` (`home`),
  KEY `away` (`away`),
  KEY `venue` (`venue`),
  KEY `odds_id` (`odds_id`),
  KEY `league` (`league`),
  KEY `ref` (`ref`),
  CONSTRAINT `match_ibfk_1` FOREIGN KEY (`home`) REFERENCES `Team` (`t_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_2` FOREIGN KEY (`away`) REFERENCES `Team` (`t_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_3` FOREIGN KEY (`venue`) REFERENCES `Stadium` (`stadium_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_4` FOREIGN KEY (`odds_id`) REFERENCES `Odds` (`odds_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_5` FOREIGN KEY (`league`) REFERENCES `League` (`league_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_6` FOREIGN KEY (`ref`) REFERENCES `Referee` (`ref_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Match`
--

LOCK TABLES `Match` WRITE;
/*!40000 ALTER TABLE `Match` DISABLE KEYS */;
/*!40000 ALTER TABLE `Match` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_leagues_games` AFTER INSERT ON `match` FOR EACH ROW BEGIN
    UPDATE League
    SET total_games = total_games + 1
    where league_name = NEW.league;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_ref_games` AFTER INSERT ON `match` FOR EACH ROW BEGIN
    UPDATE Referee
    SET games_reffed = games_reffed + 1
    where ref_id = NEW.ref;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_match_odds` AFTER DELETE ON `match` FOR EACH ROW BEGIN
    DELETE FROM odds WHERE odds_id = OLD.odds_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Odds`
--

DROP TABLE IF EXISTS `Odds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Odds` (
  `odds_id` int NOT NULL AUTO_INCREMENT,
  `under_odds` int DEFAULT NULL,
  `over_odds` int DEFAULT NULL,
  PRIMARY KEY (`odds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Odds`
--

LOCK TABLES `Odds` WRITE;
/*!40000 ALTER TABLE `Odds` DISABLE KEYS */;
/*!40000 ALTER TABLE `Odds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Player`
--

DROP TABLE IF EXISTS `Player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Player` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `p_name` varchar(64) NOT NULL,
  `nationality` varchar(64) DEFAULT NULL,
  `position` varchar(64) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `team_name` varchar(64) DEFAULT NULL,
  `player_stats` int DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `player_stats` (`player_stats`),
  KEY `team_name` (`team_name`),
  KEY `nationality` (`nationality`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`team_name`) REFERENCES `Team` (`t_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_ibfk_2` FOREIGN KEY (`nationality`) REFERENCES `Country` (`c_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_ibfk_3` FOREIGN KEY (`player_stats`) REFERENCES `Stats` (`stats_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Player`
--

LOCK TABLES `Player` WRITE;
/*!40000 ALTER TABLE `Player` DISABLE KEYS */;
/*!40000 ALTER TABLE `Player` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_player_stats` AFTER DELETE ON `player` FOR EACH ROW BEGIN
    DELETE FROM stats WHERE stats_id = OLD.player_stats;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Referee`
--

DROP TABLE IF EXISTS `Referee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Referee` (
  `ref_id` int NOT NULL AUTO_INCREMENT,
  `age` int DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `games_reffed` int DEFAULT NULL,
  PRIMARY KEY (`ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Referee`
--

LOCK TABLES `Referee` WRITE;
/*!40000 ALTER TABLE `Referee` DISABLE KEYS */;
/*!40000 ALTER TABLE `Referee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stadium`
--

DROP TABLE IF EXISTS `Stadium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stadium` (
  `stadium_id` int NOT NULL AUTO_INCREMENT,
  `stadium_name` varchar(64) NOT NULL,
  `seats` int DEFAULT NULL,
  `founded` date DEFAULT NULL,
  PRIMARY KEY (`stadium_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stadium`
--

LOCK TABLES `Stadium` WRITE;
/*!40000 ALTER TABLE `Stadium` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stadium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stats`
--

DROP TABLE IF EXISTS `Stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stats` (
  `stats_id` int NOT NULL AUTO_INCREMENT,
  `goals` int DEFAULT '0',
  `appearances` int DEFAULT '0',
  `assists` int DEFAULT '0',
  PRIMARY KEY (`stats_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stats`
--

LOCK TABLES `Stats` WRITE;
/*!40000 ALTER TABLE `Stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Team`
--

DROP TABLE IF EXISTS `Team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Team` (
  `t_name` varchar(64) NOT NULL,
  `manager_id` int DEFAULT NULL,
  `nationality` varchar(64) DEFAULT NULL,
  `founded` date DEFAULT NULL,
  `total_titles` int DEFAULT NULL,
  `historical_performance` int DEFAULT NULL,
  `home_stadium` int DEFAULT NULL,
  `league_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`t_name`),
  KEY `manager_id` (`manager_id`),
  KEY `nationality` (`nationality`),
  KEY `home_stadium` (`home_stadium`),
  KEY `league_name` (`league_name`),
  CONSTRAINT `team_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `Manager` (`manager_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_2` FOREIGN KEY (`nationality`) REFERENCES `Country` (`c_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_3` FOREIGN KEY (`home_stadium`) REFERENCES `Stadium` (`stadium_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_4` FOREIGN KEY (`league_name`) REFERENCES `League` (`league_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Team`
--

LOCK TABLES `Team` WRITE;
/*!40000 ALTER TABLE `Team` DISABLE KEYS */;
/*!40000 ALTER TABLE `Team` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_leagues_teams` AFTER INSERT ON `team` FOR EACH ROW BEGIN
    UPDATE League
    SET total_teams = total_teams + 1
    where league_name = NEW.league_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_manager_total_titles` AFTER UPDATE ON `team` FOR EACH ROW BEGIN
    UPDATE Manager
    SET titles_managed = titles_managed + (NEW.total_titles - OLD.total_titles)
    WHERE manager_id = NEW.manager_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'league'
--

--
-- Dumping routines for database 'league'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-17 17:23:16
