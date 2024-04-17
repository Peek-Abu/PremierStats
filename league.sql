CREATE DATABASE  IF NOT EXISTS `league` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `league`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: league
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
-- Table structure for table `assist`
--

DROP TABLE IF EXISTS `assist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assist` (
  `assist_id` int NOT NULL AUTO_INCREMENT,
  `assisting_player` int DEFAULT NULL,
  `goal` int DEFAULT NULL,
  PRIMARY KEY (`assist_id`),
  KEY `assisting_player` (`assisting_player`),
  KEY `goal` (`goal`),
  CONSTRAINT `assist_ibfk_1` FOREIGN KEY (`assisting_player`) REFERENCES `player` (`player_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `assist_ibfk_2` FOREIGN KEY (`goal`) REFERENCES `event` (`event_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assist`
--

LOCK TABLES `assist` WRITE;
/*!40000 ALTER TABLE `assist` DISABLE KEYS */;
INSERT INTO `assist` VALUES (1,551,1),(2,84,4),(3,84,7);
/*!40000 ALTER TABLE `assist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `c_name` varchar(64) NOT NULL,
  `leagues_hosted` int DEFAULT NULL,
  PRIMARY KEY (`c_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES ('Algeria',0),('Argentina',0),('Armenia',0),('Australia',0),('Austria',0),('Belgium',0),('Benin',0),('Bosnia and Herzegovina',0),('Brazil',0),('Cameroon',0),('Canada',0),('Chile',0),('Colombia',0),('Congo DR',0),('Croatia',0),('Curaçao',0),('Czech Republic',0),('Denmark',0),('Ecuador',0),('Egypt',0),('England',1),('Equatorial Guinea',0),('France',0),('Gabon',0),('Germany',0),('Ghana',0),('Greece',0),('Guinea',0),('Iceland',0),('Iran',0),('Israel',0),('Italy',0),('Ivory Coast',0),('Jamaica',0),('Japan',0),('Kenya',0),('Mali',0),('Mexico',0),('Montenegro',0),('Morocco',0),('Netherlands',0),('New Zealand',0),('Nigeria',0),('Northern Ireland',0),('Norway',0),('Paraguay',0),('Philippines',0),('Poland',0),('Portugal',0),('Republic of Ireland',0),('Romania',0),('Scotland',0),('Senegal',0),('Serbia',0),('Slovakia',0),('Slovenia',0),('South Korea',0),('Spain',0),('Sweden',0),('Switzerland',0),('Togo',0),('Turkey',0),('Ukraine',0),('Uruguay',0),('USA',0),('Venezuela',0),('Wales',0);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `match_id` int DEFAULT NULL,
  `player_involved` int DEFAULT NULL,
  `description` varchar(64) DEFAULT NULL,
  `event_type` enum('Goals','Cards','Substitutions') NOT NULL,
  `minute` int DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `match_id` (`match_id`),
  KEY `player_involved` (`player_involved`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`player_involved`) REFERENCES `player` (`player_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,6,411,'Goal','Goals',20),(2,1,2,'Yellow card','Cards',30),(3,14,3,'Substitution','Substitutions',80),(4,17,200,'Goal','Goals',90),(5,24,5,'Red card','Cards',70),(6,24,6,'Substitution','Substitutions',85),(7,17,200,'Goal','Goals',60);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league`
--

DROP TABLE IF EXISTS `league`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league` (
  `league_name` varchar(64) NOT NULL,
  `country_name` varchar(64) DEFAULT NULL,
  `founded` date DEFAULT NULL,
  `total_teams` int DEFAULT NULL,
  `total_games` int DEFAULT NULL,
  PRIMARY KEY (`league_name`),
  KEY `country_name` (`country_name`),
  CONSTRAINT `league_ibfk_1` FOREIGN KEY (`country_name`) REFERENCES `country` (`c_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league`
--

LOCK TABLES `league` WRITE;
/*!40000 ALTER TABLE `league` DISABLE KEYS */;
INSERT INTO `league` VALUES ('Premier League','England','1992-02-20',40,380);
/*!40000 ALTER TABLE `league` ENABLE KEYS */;
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
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `manager_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `age` int DEFAULT NULL,
  `years_managing` int DEFAULT NULL,
  `titles_managed` int DEFAULT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'Unai Emery',38,0,0),(2,'Mauricio Pochettino',48,0,0),(3,'Pep Guardiola',49,0,0),(4,'Brendan Rodgers',47,0,0),(5,'Roy Hodgson',60,0,0),(6,'Marco Silva',43,0,0),(7,'Sean Dyche',49,0,0),(8,'Ralph Hasenhuttl',52,0,0),(9,'Eddie Howe',42,0,0),(10,'Ole Gunnar Solskjaer',47,0,0),(11,'Jurgen Klopp',53,0,0),(12,'Maurizio Sarri',42,0,0),(13,'Manuel Pellegr',65,0,0),(14,'Javi Gracia',50,0,0),(15,'Rafael Benitez',60,0,0),(16,'Neil Warnock',70,0,0),(17,'Scott Parker',40,0,0),(18,'Chris Hughton',50,0,0),(19,'Jan Siewert',38,0,0),(20,'Nuno Espirito Santo',46,0,0);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match`
--

DROP TABLE IF EXISTS `match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match` (
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
  CONSTRAINT `match_ibfk_1` FOREIGN KEY (`home`) REFERENCES `team` (`t_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_2` FOREIGN KEY (`away`) REFERENCES `team` (`t_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_3` FOREIGN KEY (`venue`) REFERENCES `stadium` (`stadium_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_4` FOREIGN KEY (`odds_id`) REFERENCES `odds` (`odds_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_5` FOREIGN KEY (`league`) REFERENCES `league` (`league_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `match_ibfk_6` FOREIGN KEY (`ref`) REFERENCES `referee` (`ref_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match`
--

LOCK TABLES `match` WRITE;
/*!40000 ALTER TABLE `match` DISABLE KEYS */;
INSERT INTO `match` VALUES (1,1,'2018-08-10',1,'Manchester United','Leicester City','2-1',74439,1,NULL),(2,1,'2018-08-19',18,'Manchester City','Huddersfield Town','6-1',54021,18,NULL),(3,1,'2018-09-02',6,'Watford','Tottenham Hotspur','2-1',20141,40,NULL),(4,1,'2018-09-16',7,'Wolverhampton Wanderers','Burnley','1-0',30406,48,NULL),(5,1,'2018-09-22',20,'Crystal Palace','Newcastle United','0-0',25679,54,NULL),(6,1,'2018-09-29',16,'Chelsea','Liverpool','1-1',40625,68,NULL),(7,1,'2018-10-06',13,'Leicester City','Everton','1-2',32007,74,NULL),(8,1,'2018-10-20',2,'Newcastle United','Brighton & Hove Albion','0-1',50329,85,NULL),(9,1,'2018-10-27',4,'Fulham','AFC Bournemouth','0-3',25071,92,NULL),(10,1,'2018-11-03',10,'Arsenal','Liverpool','1-1',59993,106,NULL),(11,1,'2018-11-24',15,'West Ham United','Manchester City','0-4',56886,126,NULL),(12,1,'2018-11-30',11,'Cardiff City','Wolverhampton Wanderers','2-1',30213,131,NULL),(13,1,'2018-12-05',1,'Manchester United','Arsenal','2-2',74507,149,NULL),(14,1,'2018-12-22',18,'Manchester City','Crystal Palace','2-3',54340,176,NULL),(15,1,'2018-12-26',4,'Fulham','Wolverhampton Wanderers','1-1',24382,181,NULL),(16,1,'2019-01-02',2,'Newcastle United','Manchester United','0-2',52217,209,NULL),(17,1,'2019-01-20',5,'Huddersfield Town','Manchester City','0-3',24190,229,NULL),(18,1,'2019-01-30',9,'Southampton','Crystal Palace','1-1',28339,238,NULL),(19,1,'2019-02-02',14,'Tottenham Hotspur','Newcastle United','1-0',41219,241,NULL),(20,1,'2019-02-27',16,'Chelsea','Tottenham Hotspur','2-0',40542,277,NULL),(21,1,'2019-03-02',7,'Wolverhampton Wanderers','Cardiff City','2-0',31309,285,NULL),(22,1,'2019-03-10',8,'Liverpool','Burnley','4-2',53310,297,NULL),(23,1,'2019-04-03',21,'Tottenham Hotspur','Crystal Palace','2-0',59215,318,NULL),(24,1,'2019-04-16',19,'Brighton & Hove Albion','Cardiff City','0-2',30226,336,NULL),(25,1,'2019-04-24',1,'Manchester United','Manchester City','0-2',74431,350,NULL),(26,1,'2019-05-04',2,'Newcastle United','Liverpool','2-3',52206,366,NULL),(27,1,'2019-05-12',21,'Tottenham Hotspur','Everton','2-2',60124,379,NULL),(28,2,'2018-08-11',2,'Newcastle United','Tottenham Hotspur','1-2',51749,2,NULL),(29,2,'2018-08-18',16,'Chelsea','Arsenal','3-2',40491,16,NULL),(30,2,'2018-08-25',7,'Wolverhampton Wanderers','Manchester City','1-1',31222,21,NULL),(31,2,'2018-09-01',20,'Crystal Palace','Southampton','0-2',25495,34,NULL),(32,2,'2018-09-16',12,'Everton','West Ham United','1-3',39161,49,NULL),(33,2,'2018-09-22',4,'Fulham','Watford','1-1',23418,51,NULL),(34,2,'2018-09-30',11,'Cardiff City','Burnley','1-2',30411,69,NULL),(35,2,'2018-10-07',8,'Liverpool','Manchester City','0-0',52117,80,NULL),(36,2,'2018-10-20',15,'West Ham United','Tottenham Hotspur','0-1',56921,86,NULL),(37,2,'2018-10-28',20,'Crystal Palace','Arsenal','2-2',25718,98,NULL),(38,2,'2018-11-10',11,'Cardiff City','Brighton & Hove Albion','2-1',29402,111,NULL),(39,2,'2018-11-24',14,'Tottenham Hotspur','Chelsea','3-1',55465,127,NULL),(40,2,'2018-12-08',17,'Burnley','Brighton & Hove Albion','1-0',18497,153,NULL),(41,2,'2018-12-16',8,'Liverpool','Manchester United','3-1',52908,170,NULL),(42,2,'2018-12-22',2,'Newcastle United','Fulham','0-0',51237,177,NULL),(43,2,'2018-12-26',6,'Watford','Chelsea','1-2',20415,189,NULL),(44,2,'2019-01-01',12,'Everton','Leicester City','0-1',39052,201,NULL),(45,2,'2019-01-12',17,'Burnley','Fulham','2-1',19316,213,NULL),(46,2,'2019-01-30',8,'Liverpool','Leicester City','1-1',53092,239,NULL),(47,2,'2019-02-03',18,'Manchester City','Arsenal','3-1',54483,249,NULL),(48,2,'2019-02-09',9,'Southampton','Cardiff City','1-2',31438,256,NULL),(49,2,'2019-02-27',20,'Crystal Palace','Manchester United','1-3',25754,276,NULL),(50,2,'2019-03-03',12,'Everton','Liverpool','0-0',39335,289,NULL),(51,2,'2019-03-31',8,'Liverpool','Tottenham Hotspur','2-1',53322,313,NULL),(52,2,'2019-04-06',3,'AFC Bournemouth','Burnley','1-3',10446,321,NULL),(53,2,'2019-04-14',20,'Crystal Palace','Manchester City','1-3',25721,333,NULL),(54,2,'2019-04-21',11,'Cardiff City','Liverpool','0-2',33082,345,NULL),(55,2,'2019-04-28',1,'Manchester United','Chelsea','1-1',74526,360,NULL),(56,2,'2019-05-12',8,'Liverpool','Wolverhampton Wanderers','2-0',53331,376,NULL),(57,3,'2018-08-11',3,'AFC Bournemouth','Cardiff City','2-0',10353,3,NULL),(58,3,'2018-08-19',19,'Brighton & Hove Albion','Manchester United','3-2',30592,19,NULL),(59,3,'2018-09-01',18,'Manchester City','Newcastle United','2-1',53946,37,NULL),(60,3,'2018-09-22',1,'Manchester United','Wolverhampton Wanderers','1-1',74489,57,NULL),(61,3,'2018-10-05',19,'Brighton & Hove Albion','West Ham United','1-0',30544,71,NULL),(62,3,'2018-10-20',11,'Cardiff City','Fulham','4-2',29681,83,NULL),(63,3,'2018-10-29',14,'Tottenham Hotspur','Manchester City','0-1',56854,100,NULL),(64,3,'2018-11-11',16,'Chelsea','Everton','0-0',40345,118,NULL),(65,3,'2018-11-25',7,'Wolverhampton Wanderers','Huddersfield Town','0-2',30130,129,NULL),(66,3,'2018-12-01',9,'Southampton','Manchester United','2-2',30187,137,NULL),(67,3,'2018-12-04',19,'Brighton & Hove Albion','Crystal Palace','3-1',29663,142,NULL),(68,3,'2018-12-10',12,'Everton','Watford','2-2',38400,160,NULL),(69,3,'2018-12-22',10,'Arsenal','Burnley','3-1',59493,172,NULL),(70,3,'2018-12-29',4,'Fulham','Huddersfield Town','1-0',24423,192,NULL),(71,3,'2019-01-01',11,'Cardiff City','Tottenham Hotspur','0-3',32485,203,NULL),(72,3,'2019-01-12',19,'Brighton & Hove Albion','Liverpool','0-1',30862,212,NULL),(73,3,'2019-02-04',15,'West Ham United','Liverpool','1-1',59903,250,NULL),(74,3,'2019-02-23',2,'Newcastle United','Huddersfield Town','2-0',52174,266,NULL),(75,3,'2019-02-26',11,'Cardiff City','Everton','0-3',31849,270,NULL),(76,3,'2019-03-02',3,'AFC Bournemouth','Manchester City','0-1',10699,281,NULL),(77,3,'2019-03-09',9,'Southampton','Tottenham Hotspur','2-1',31890,295,NULL),(78,3,'2019-03-30',4,'Fulham','Manchester City','0-2',25001,305,NULL),(79,3,'2019-04-07',12,'Everton','Arsenal','1-0',39400,324,NULL),(80,3,'2019-04-13',19,'Brighton & Hove Albion','AFC Bournemouth','0-5',30460,328,NULL),(81,3,'2019-04-22',16,'Chelsea','Burnley','2-2',40642,346,NULL),(82,3,'2019-04-26',8,'Liverpool','Huddersfield Town','5-0',53249,351,NULL),(83,3,'2019-05-12',4,'Fulham','Newcastle United','0-4',24979,374,NULL),(84,4,'2018-08-11',4,'Fulham','Crystal Palace','0-2',24821,4,NULL),(85,4,'2018-08-18',13,'Leicester City','Wolverhampton Wanderers','2-0',32043,13,NULL),(86,4,'2018-09-15',6,'Watford','Manchester United','1-2',20537,47,NULL),(87,4,'2018-09-23',15,'West Ham United','Chelsea','0-0',56875,59,NULL),(88,4,'2018-10-01',3,'AFC Bournemouth','Crystal Palace','2-1',10199,70,NULL),(89,4,'2018-10-06',14,'Tottenham Hotspur','Cardiff City','1-0',43268,75,NULL),(90,4,'2018-10-20',16,'Chelsea','Manchester United','2-2',40721,81,NULL),(91,4,'2018-10-27',6,'Watford','Huddersfield Town','3-0',20457,95,NULL),(92,4,'2018-11-03',7,'Wolverhampton Wanderers','Tottenham Hotspur','2-3',31185,107,NULL),(93,4,'2018-11-10',13,'Leicester City','Burnley','0-0',32184,113,NULL),(94,4,'2018-12-02',10,'Arsenal','Tottenham Hotspur','4-2',59973,139,NULL),(95,4,'2018-12-09',2,'Newcastle United','Wolverhampton Wanderers','1-2',50223,159,NULL),(96,4,'2018-12-15',4,'Fulham','West Ham United','0-2',24081,167,NULL),(97,4,'2018-12-22',3,'AFC Bournemouth','Brighton & Hove Albion','2-0',10491,173,NULL),(98,4,'2018-12-26',13,'Leicester City','Manchester City','2-1',32090,184,NULL),(99,4,'2019-01-02',5,'Huddersfield Town','Burnley','1-2',23715,205,NULL),(100,4,'2019-01-13',14,'Tottenham Hotspur','Manchester United','0-1',80062,219,NULL),(101,4,'2019-01-29',10,'Arsenal','Cardiff City','2-1',59933,231,NULL),(102,4,'2019-02-03',13,'Leicester City','Manchester United','0-1',32148,248,NULL),(103,4,'2019-02-10',18,'Manchester City','Chelsea','6-0',54452,260,NULL),(104,4,'2019-02-23',17,'Burnley','Tottenham Hotspur','2-1',21338,264,NULL),(105,4,'2019-03-02',19,'Brighton & Hove Albion','Huddersfield Town','1-0',30182,282,NULL),(106,4,'2019-03-16',3,'AFC Bournemouth','Newcastle United','2-2',10625,300,NULL),(107,4,'2019-04-02',7,'Wolverhampton Wanderers','Manchester United','2-1',31302,316,NULL),(108,4,'2019-04-13',17,'Burnley','Cardiff City','2-0',21480,329,NULL),(109,4,'2019-04-23',6,'Watford','Southampton','1-1',19170,347,NULL),(110,4,'2019-04-27',19,'Brighton & Hove Albion','Newcastle United','1-1',30587,357,NULL),(111,4,'2019-05-06',18,'Manchester City','Leicester City','1-0',54506,370,NULL),(112,4,'2019-05-12',17,'Burnley','Arsenal','1-3',21461,372,NULL),(113,5,'2018-08-11',5,'Huddersfield Town','Chelsea','0-3',24121,5,NULL),(114,5,'2018-08-25',8,'Liverpool','Brighton & Hove Albion','1-0',53294,26,NULL),(115,5,'2018-09-01',15,'West Ham United','Wolverhampton Wanderers','0-1',59947,36,NULL),(116,5,'2018-09-22',19,'Brighton & Hove Albion','Tottenham Hotspur','1-2',30531,58,NULL),(117,5,'2018-10-06',17,'Burnley','Huddersfield Town','1-1',20533,72,NULL),(118,5,'2018-10-22',10,'Arsenal','Leicester City','3-1',59886,90,NULL),(119,5,'2018-10-27',9,'Southampton','Newcastle United','0-0',30736,94,NULL),(120,5,'2018-11-10',5,'Huddersfield Town','West Ham United','1-1',24069,112,NULL),(121,5,'2018-11-24',19,'Brighton & Hove Albion','Leicester City','1-1',30553,121,NULL),(122,5,'2018-12-02',8,'Liverpool','Everton','1-0',51756,140,NULL),(123,5,'2018-12-16',9,'Southampton','Arsenal','3-2',29497,169,NULL),(124,5,'2018-12-26',14,'Tottenham Hotspur','AFC Bournemouth','5-0',45154,187,NULL),(125,5,'2019-01-02',15,'West Ham United','Brighton & Hove Albion','2-2',59870,206,NULL),(126,5,'2019-01-12',16,'Chelsea','Newcastle United','2-1',40491,217,NULL),(127,5,'2019-01-19',7,'Wolverhampton Wanderers','Leicester City','4-3',31278,221,NULL),(128,5,'2019-02-27',10,'Arsenal','AFC Bournemouth','5-1',59618,274,NULL),(129,5,'2019-03-02',15,'West Ham United','Newcastle United','2-0',59910,286,NULL),(130,5,'2019-03-30',17,'Burnley','Wolverhampton Wanderers','2-0',20990,307,NULL),(131,5,'2019-04-08',16,'Chelsea','West Ham United','2-0',40537,325,NULL),(132,5,'2019-04-12',13,'Leicester City','Newcastle United','0-1',32108,326,NULL),(133,5,'2019-04-23',21,'Tottenham Hotspur','Brighton & Hove Albion','1-0',56251,348,NULL),(134,5,'2019-04-27',4,'Fulham','Cardiff City','1-0',23822,354,NULL),(135,5,'2019-05-03',12,'Everton','Burnley','2-0',39303,361,NULL),(136,5,'2019-05-12',6,'Watford','West Ham United','1-4',20067,380,NULL),(137,6,'2018-08-11',6,'Watford','Brighton & Hove Albion','2-0',20051,6,NULL),(138,6,'2018-08-25',9,'Southampton','Leicester City','1-2',29925,25,NULL),(139,6,'2018-09-02',17,'Burnley','Manchester United','0-2',21525,39,NULL),(140,6,'2018-09-15',16,'Chelsea','Cardiff City','4-1',40499,43,NULL),(141,6,'2018-09-23',10,'Arsenal','Everton','2-0',59964,60,NULL),(142,6,'2018-10-06',6,'Watford','AFC Bournemouth','0-4',20139,76,NULL),(143,6,'2018-10-20',18,'Manchester City','Burnley','5-0',54094,84,NULL),(144,6,'2018-10-28',1,'Manchester United','Everton','2-1',74525,99,NULL),(145,6,'2018-11-10',20,'Crystal Palace','Tottenham Hotspur','0-1',25685,116,NULL),(146,6,'2018-11-24',6,'Watford','Liverpool','0-3',20540,125,NULL),(147,6,'2018-12-05',7,'Wolverhampton Wanderers','Chelsea','2-1',31300,147,NULL),(148,6,'2018-12-08',11,'Cardiff City','Southampton','1-0',30067,154,NULL),(149,6,'2018-12-26',1,'Manchester United','Huddersfield Town','3-1',74523,186,NULL),(150,6,'2019-01-02',16,'Chelsea','Southampton','0-0',40668,204,NULL),(151,6,'2019-01-12',15,'West Ham United','Arsenal','1-0',59946,211,NULL),(152,6,'2019-01-19',8,'Liverpool','Crystal Palace','4-3',53171,223,NULL),(153,6,'2019-01-29',1,'Manchester United','Burnley','2-2',74529,235,NULL),(154,6,'2019-02-02',11,'Cardiff City','AFC Bournemouth','2-0',31939,247,NULL),(155,6,'2019-02-09',5,'Huddersfield Town','Arsenal','1-2',24182,254,NULL),(156,6,'2019-03-03',6,'Watford','Leicester City','2-1',20062,287,NULL),(157,6,'2019-03-10',10,'Arsenal','Manchester United','2-0',60000,299,NULL),(158,6,'2019-03-16',15,'West Ham United','Huddersfield Town','4-3',59931,302,NULL),(159,6,'2019-04-03',18,'Manchester City','Cardiff City','2-0',53559,319,NULL),(160,6,'2019-04-13',9,'Southampton','Wolverhampton Wanderers','3-1',31708,331,NULL),(161,6,'2019-04-21',10,'Arsenal','Crystal Palace','2-3',59929,344,NULL),(162,6,'2019-05-04',7,'Wolverhampton Wanderers','Fulham','1-0',30456,364,NULL),(163,6,'2019-05-12',1,'Manchester United','Cardiff City','0-2',74457,377,NULL),(164,7,'2018-08-11',7,'Wolverhampton Wanderers','Everton','2-2',31231,7,NULL),(165,7,'2018-08-18',11,'Cardiff City','Newcastle United','0-0',30720,11,NULL),(166,7,'2018-08-27',1,'Manchester United','Tottenham Hotspur','0-3',74400,30,NULL),(167,7,'2018-09-15',3,'AFC Bournemouth','Leicester City','4-2',10543,42,NULL),(168,7,'2018-09-29',5,'Huddersfield Town','Tottenham Hotspur','0-2',23885,64,NULL),(169,7,'2018-10-07',9,'Southampton','Chelsea','0-3',27077,79,NULL),(170,7,'2018-10-28',17,'Burnley','Chelsea','0-4',21430,97,NULL),(171,7,'2018-11-03',2,'Newcastle United','Watford','1-0',49157,104,NULL),(172,7,'2018-11-25',3,'AFC Bournemouth','Arsenal','1-2',10792,128,NULL),(173,7,'2018-12-02',16,'Chelsea','Fulham','2-0',40551,138,NULL),(174,7,'2018-12-08',13,'Leicester City','Tottenham Hotspur','0-2',31957,158,NULL),(175,7,'2018-12-15',18,'Manchester City','Everton','3-1',54173,161,NULL),(176,7,'2018-12-21',7,'Wolverhampton Wanderers','Liverpool','0-2',31358,171,NULL),(177,7,'2018-12-27',9,'Southampton','West Ham United','1-2',31654,190,NULL),(178,7,'2018-12-30',20,'Crystal Palace','Chelsea','0-1',25781,197,NULL),(179,7,'2019-01-14',18,'Manchester City','Wolverhampton Wanderers','3-0',54171,220,NULL),(180,7,'2019-01-20',4,'Fulham','Tottenham Hotspur','1-2',24807,230,NULL),(181,7,'2019-02-06',12,'Everton','Manchester City','0-2',39322,251,NULL),(182,7,'2019-02-09',20,'Crystal Palace','West Ham United','1-1',25552,253,NULL),(183,7,'2019-02-26',2,'Newcastle United','Burnley','2-0',48323,273,NULL),(184,7,'2019-03-09',20,'Crystal Palace','Brighton & Hove Albion','1-2',24972,290,NULL),(185,7,'2019-03-17',4,'Fulham','Liverpool','1-2',25043,303,NULL),(186,7,'2019-03-31',11,'Cardiff City','Chelsea','1-2',32657,312,NULL),(187,7,'2019-04-15',6,'Watford','Arsenal','0-1',20480,335,NULL),(188,7,'2019-04-20',7,'Wolverhampton Wanderers','Brighton & Hove Albion','0-0',31096,341,NULL),(189,7,'2019-05-04',3,'AFC Bournemouth','Tottenham Hotspur','1-0',10630,362,NULL),(190,8,'2018-08-12',8,'Liverpool','West Ham United','4-0',53235,8,NULL),(191,8,'2018-08-18',14,'Tottenham Hotspur','Fulham','3-1',58297,14,NULL),(192,8,'2018-08-26',6,'Watford','Crystal Palace','2-1',20014,27,NULL),(193,8,'2018-09-02',11,'Cardiff City','Arsenal','2-3',32316,38,NULL),(194,8,'2018-09-17',9,'Southampton','Brighton & Hove Albion','2-2',27742,50,NULL),(195,8,'2018-09-22',17,'Burnley','AFC Bournemouth','4-0',18636,52,NULL),(196,8,'2018-09-29',10,'Arsenal','Watford','2-0',60019,62,NULL),(197,8,'2018-10-06',1,'Manchester United','Newcastle United','3-2',74519,77,NULL),(198,8,'2018-10-21',12,'Everton','Crystal Palace','2-0',38668,89,NULL),(199,8,'2018-10-27',19,'Brighton & Hove Albion','Wolverhampton Wanderers','1-0',30654,91,NULL),(200,8,'2018-11-05',5,'Huddersfield Town','Fulham','1-0',17082,110,NULL),(201,8,'2018-11-11',18,'Manchester City','Manchester United','3-1',54316,120,NULL),(202,8,'2018-11-26',17,'Burnley','Newcastle United','1-2',20628,130,NULL),(203,8,'2018-12-05',14,'Tottenham Hotspur','Southampton','3-1',33012,150,NULL),(204,8,'2018-12-08',15,'West Ham United','Crystal Palace','3-2',56995,156,NULL),(205,8,'2018-12-15',5,'Huddersfield Town','Newcastle United','0-1',24036,163,NULL),(206,8,'2018-12-26',19,'Brighton & Hove Albion','Arsenal','1-1',30608,188,NULL),(207,8,'2019-01-03',18,'Manchester City','Liverpool','2-1',54511,210,NULL),(208,8,'2019-01-13',12,'Everton','AFC Bournemouth','2-0',38113,218,NULL),(209,8,'2019-01-19',10,'Arsenal','Chelsea','2-0',59979,228,NULL),(210,8,'2019-02-02',17,'Burnley','Southampton','1-1',19787,243,NULL),(211,8,'2019-02-09',8,'Liverpool','AFC Bournemouth','3-0',53178,255,NULL),(212,8,'2019-02-23',13,'Leicester City','Crystal Palace','1-4',31778,267,NULL),(213,8,'2019-02-27',9,'Southampton','Fulham','2-0',27597,275,NULL),(214,8,'2019-03-02',14,'Tottenham Hotspur','Arsenal','1-1',81332,280,NULL),(215,8,'2019-03-09',5,'Huddersfield Town','AFC Bournemouth','0-2',22304,292,NULL),(216,8,'2019-03-17',12,'Everton','Chelsea','2-0',39356,304,NULL),(217,8,'2019-04-01',10,'Arsenal','Newcastle United','2-0',59869,314,NULL),(218,8,'2019-04-20',2,'Newcastle United','Southampton','3-1',52191,342,NULL),(219,8,'2019-04-27',21,'Tottenham Hotspur','West Ham United','0-1',60043,352,NULL),(220,8,'2019-05-05',10,'Arsenal','Brighton & Hove Albion','1-1',59965,369,NULL),(221,8,'2019-05-12',13,'Leicester City','Chelsea','0-0',32140,375,NULL),(222,9,'2018-08-12',9,'Southampton','Burnley','0-0',30784,9,NULL),(223,9,'2018-08-25',10,'Arsenal','West Ham United','3-1',59830,23,NULL),(224,9,'2018-12-01',13,'Leicester City','Watford','2-0',31353,134,NULL),(225,9,'2018-12-04',15,'West Ham United','Cardiff City','3-1',56811,143,NULL),(226,9,'2018-12-15',14,'Tottenham Hotspur','Burnley','1-0',41645,164,NULL),(227,9,'2018-12-26',8,'Liverpool','Newcastle United','4-0',53318,185,NULL),(228,9,'2019-01-01',10,'Arsenal','Fulham','4-1',59887,202,NULL),(229,9,'2019-01-19',9,'Southampton','Everton','2-1',29989,226,NULL),(230,9,'2019-01-30',14,'Tottenham Hotspur','Watford','2-1',29164,240,NULL),(231,9,'2019-02-11',7,'Wolverhampton Wanderers','Newcastle United','1-1',30687,261,NULL),(232,9,'2019-02-24',10,'Arsenal','Southampton','2-0',59877,268,NULL),(233,9,'2019-02-27',8,'Liverpool','Watford','5-0',53316,278,NULL),(234,9,'2019-03-03',4,'Fulham','Chelsea','1-2',24900,288,NULL),(235,9,'2019-03-09',11,'Cardiff City','West Ham United','2-0',32458,291,NULL),(236,9,'2019-04-03',16,'Chelsea','Brighton & Hove Albion','3-0',38593,317,NULL),(237,9,'2019-04-13',1,'Manchester United','West Ham United','2-1',74478,332,NULL),(238,9,'2019-04-27',9,'Southampton','AFC Bournemouth','3-3',31310,355,NULL),(239,10,'2018-08-12',10,'Arsenal','Manchester City','0-2',59934,10,NULL),(240,10,'2018-08-20',20,'Crystal Palace','Liverpool','0-2',25750,20,NULL),(241,10,'2018-08-25',5,'Huddersfield Town','Cardiff City','0-0',21193,24,NULL),(242,10,'2018-09-15',14,'Tottenham Hotspur','Liverpool','1-2',80188,41,NULL),(243,10,'2018-09-22',11,'Cardiff City','Manchester City','0-5',32321,53,NULL),(244,10,'2018-09-29',15,'West Ham United','Manchester United','3-1',56938,61,NULL),(245,10,'2018-10-06',20,'Crystal Palace','Wolverhampton Wanderers','0-1',25715,73,NULL),(246,10,'2018-10-20',5,'Huddersfield Town','Liverpool','0-1',24263,88,NULL),(247,10,'2018-10-27',13,'Leicester City','West Ham United','1-1',31848,96,NULL),(248,10,'2018-11-04',16,'Chelsea','Crystal Palace','3-1',40407,109,NULL),(249,10,'2018-11-24',4,'Fulham','Southampton','3-2',24603,123,NULL),(250,10,'2018-12-01',5,'Huddersfield Town','Brighton & Hove Albion','1-2',22973,133,NULL),(251,10,'2018-12-08',16,'Chelsea','Manchester City','2-0',40571,157,NULL),(252,10,'2018-12-15',20,'Crystal Palace','Leicester City','1-0',24738,162,NULL),(253,10,'2018-12-22',11,'Cardiff City','Manchester United','1-5',33028,179,NULL),(254,10,'2018-12-26',17,'Burnley','Everton','1-5',21484,182,NULL),(255,10,'2018-12-29',8,'Liverpool','Arsenal','5-1',53326,196,NULL),(256,10,'2019-01-12',13,'Leicester City','Southampton','1-2',31491,216,NULL),(257,10,'2019-01-19',6,'Watford','Burnley','0-0',19510,227,NULL),(258,10,'2019-02-02',20,'Crystal Palace','Fulham','2-0',25355,245,NULL),(259,10,'2019-02-10',14,'Tottenham Hotspur','Leicester City','3-1',44154,259,NULL),(260,10,'2019-02-24',1,'Manchester United','Liverpool','0-0',74519,269,NULL),(261,10,'2019-03-10',16,'Chelsea','Wolverhampton Wanderers','1-1',40692,298,NULL),(262,10,'2019-03-16',17,'Burnley','Leicester City','1-2',20719,301,NULL),(263,10,'2019-03-30',19,'Brighton & Hove Albion','Southampton','0-1',30636,306,NULL),(264,10,'2019-04-14',8,'Liverpool','Chelsea','2-0',53279,334,NULL),(265,10,'2019-04-20',18,'Manchester City','Tottenham Hotspur','1-0',54489,337,NULL),(266,10,'2019-04-28',13,'Leicester City','Arsenal','3-0',32037,358,NULL),(267,10,'2019-05-04',11,'Cardiff City','Crystal Palace','2-3',32133,365,NULL),(268,10,'2019-05-12',19,'Brighton & Hove Albion','Manchester City','1-4',30662,371,NULL),(269,11,'2018-08-18',12,'Everton','Southampton','2-1',38601,12,NULL),(270,11,'2018-09-01',16,'Chelsea','AFC Bournemouth','2-0',40178,33,NULL),(271,11,'2018-09-15',5,'Huddersfield Town','Crystal Palace','0-1',23696,44,NULL),(272,11,'2018-09-29',18,'Manchester City','Brighton & Hove Albion','2-0',54152,65,NULL),(273,11,'2018-10-20',7,'Wolverhampton Wanderers','Watford','0-2',31144,87,NULL),(274,11,'2018-11-04',18,'Manchester City','Southampton','6-1',53916,108,NULL),(275,11,'2018-11-24',1,'Manchester United','Crystal Palace','0-0',74516,124,NULL),(276,11,'2018-12-05',12,'Everton','Newcastle United','1-1',39350,148,NULL),(277,11,'2018-12-08',3,'AFC Bournemouth','Liverpool','0-4',10752,151,NULL),(278,11,'2018-12-22',15,'West Ham United','Watford','0-2',56833,178,NULL),(279,11,'2018-12-30',1,'Manchester United','AFC Bournemouth','4-1',74556,200,NULL),(280,11,'2019-01-12',11,'Cardiff City','Huddersfield Town','0-0',30725,214,NULL),(281,11,'2019-02-02',12,'Everton','Wolverhampton Wanderers','1-3',39380,246,NULL),(282,11,'2019-02-22',15,'West Ham United','Fulham','3-1',59950,263,NULL),(283,11,'2019-03-09',2,'Newcastle United','Everton','3-2',52242,294,NULL),(284,11,'2019-03-30',13,'Leicester City','AFC Bournemouth','2-0',31530,309,NULL),(285,11,'2019-04-13',21,'Tottenham Hotspur','Huddersfield Town','4-0',58308,327,NULL),(286,11,'2019-04-27',20,'Crystal Palace','Everton','0-0',25789,353,NULL),(287,11,'2019-05-05',5,'Huddersfield Town','Manchester United','1-1',24263,368,NULL),(288,12,'2018-08-18',15,'West Ham United','AFC Bournemouth','1-2',56888,15,NULL),(289,12,'2018-09-01',12,'Everton','Huddersfield Town','1-1',38767,35,NULL),(290,12,'2018-09-15',18,'Manchester City','Fulham','3-0',53307,45,NULL),(291,12,'2018-09-29',7,'Wolverhampton Wanderers','Southampton','2-0',31147,67,NULL),(292,12,'2018-10-27',8,'Liverpool','Cardiff City','4-1',53373,93,NULL),(293,12,'2018-11-11',10,'Arsenal','Wolverhampton Wanderers','1-1',60030,119,NULL),(294,12,'2018-12-01',18,'Manchester City','AFC Bournemouth','3-1',54409,135,NULL),(295,12,'2018-12-05',17,'Burnley','Liverpool','1-3',21741,145,NULL),(296,12,'2018-12-16',19,'Brighton & Hove Albion','Chelsea','1-2',30645,168,NULL),(297,12,'2018-12-22',5,'Huddersfield Town','Southampton','1-3',22394,175,NULL),(298,12,'2018-12-29',14,'Tottenham Hotspur','Wolverhampton Wanderers','1-3',46356,194,NULL),(299,12,'2019-01-19',2,'Newcastle United','Cardiff City','3-0',49864,225,NULL),(300,12,'2019-01-29',5,'Huddersfield Town','Everton','0-1',23699,233,NULL),(301,12,'2019-02-09',19,'Brighton & Hove Albion','Burnley','1-3',29323,258,NULL),(302,12,'2019-02-27',18,'Manchester City','West Ham United','1-0',53528,279,NULL),(303,12,'2019-03-02',1,'Manchester United','Southampton','3-2',74459,284,NULL),(304,12,'2019-03-30',1,'Manchester United','Watford','2-1',74543,310,NULL),(305,12,'2019-04-06',2,'Newcastle United','Crystal Palace','0-1',51926,323,NULL),(306,12,'2019-04-24',7,'Wolverhampton Wanderers','Arsenal','3-1',31436,349,NULL),(307,12,'2019-05-04',15,'West Ham United','Southampton','3-0',59961,363,NULL),(308,13,'2018-08-19',17,'Burnley','Watford','1-3',18822,17,NULL),(309,13,'2018-08-26',2,'Newcastle United','Chelsea','1-2',51791,29,NULL),(310,13,'2018-09-01',13,'Leicester City','Liverpool','1-2',32149,31,NULL),(311,13,'2018-09-22',8,'Liverpool','Southampton','3-0',50965,56,NULL),(312,13,'2018-10-07',4,'Fulham','Arsenal','1-5',25401,78,NULL),(313,13,'2018-11-03',3,'AFC Bournemouth','Manchester United','1-2',10792,101,NULL),(314,13,'2018-11-11',8,'Liverpool','Fulham','2-0',53128,117,NULL),(315,13,'2018-11-24',12,'Everton','Cardiff City','1-0',39139,122,NULL),(316,13,'2018-12-01',2,'Newcastle United','West Ham United','0-3',51853,136,NULL),(317,13,'2018-12-04',6,'Watford','Manchester City','1-2',20389,144,NULL),(318,13,'2018-12-08',10,'Arsenal','Huddersfield Town','1-0',59893,152,NULL),(319,13,'2018-12-23',12,'Everton','Tottenham Hotspur','2-6',39319,180,NULL),(320,13,'2018-12-30',9,'Southampton','Manchester City','1-3',31381,199,NULL),(321,13,'2019-01-12',20,'Crystal Palace','Watford','1-2',25010,215,NULL),(322,13,'2019-01-19',1,'Manchester United','Brighton & Hove Albion','2-1',74532,224,NULL),(323,13,'2019-01-29',2,'Newcastle United','Manchester City','2-1',50861,236,NULL),(324,13,'2019-02-02',16,'Chelsea','Huddersfield Town','5-0',40626,244,NULL),(325,13,'2019-02-09',4,'Fulham','Manchester United','0-3',25001,252,NULL),(326,13,'2019-03-09',18,'Manchester City','Watford','3-1',54104,296,NULL),(327,13,'2019-03-30',15,'West Ham United','Everton','0-2',59988,311,NULL),(328,13,'2019-04-05',9,'Southampton','Liverpool','1-3',31797,320,NULL),(329,13,'2019-04-21',12,'Everton','Manchester United','4-0',39395,343,NULL),(330,13,'2019-04-28',17,'Burnley','Manchester City','0-1',21605,359,NULL),(331,13,'2019-05-05',16,'Chelsea','Watford','3-0',40650,367,NULL),(332,14,'2018-08-25',3,'AFC Bournemouth','Everton','2-2',10654,22,NULL),(333,14,'2018-09-01',19,'Brighton & Hove Albion','Fulham','2-2',30526,32,NULL),(334,14,'2018-09-15',2,'Newcastle United','Arsenal','1-2',52165,46,NULL),(335,14,'2018-10-20',3,'AFC Bournemouth','Southampton','0-0',10986,82,NULL),(336,14,'2018-11-03',11,'Cardiff City','Leicester City','0-1',30877,102,NULL),(337,14,'2018-11-10',2,'Newcastle United','AFC Bournemouth','2-1',49266,114,NULL),(338,14,'2018-12-01',20,'Crystal Palace','Burnley','2-0',25098,132,NULL),(339,14,'2018-12-08',1,'Manchester United','Fulham','4-1',74523,155,NULL),(340,14,'2018-12-22',16,'Chelsea','Leicester City','0-1',40558,174,NULL),(341,14,'2018-12-26',20,'Crystal Palace','Cardiff City','0-0',25206,183,NULL),(342,14,'2019-01-29',4,'Fulham','Brighton & Hove Albion','4-2',22008,232,NULL),(343,14,'2019-02-09',6,'Watford','Everton','1-0',20333,257,NULL),(344,14,'2019-02-26',13,'Leicester City','Brighton & Hove Albion','2-1',30558,272,NULL),(345,14,'2019-03-02',17,'Burnley','Crystal Palace','1-3',19223,283,NULL),(346,14,'2019-03-30',20,'Crystal Palace','Huddersfield Town','2-0',25193,308,NULL),(347,14,'2019-04-13',4,'Fulham','Everton','2-0',24971,330,NULL),(348,14,'2019-04-20',15,'West Ham United','Leicester City','2-2',59960,340,NULL),(349,14,'2019-05-12',9,'Southampton','Huddersfield Town','1-1',30367,378,NULL),(350,15,'2018-08-26',4,'Fulham','Burnley','4-2',23438,28,NULL),(351,15,'2018-09-22',13,'Leicester City','Huddersfield Town','3-1',31676,55,NULL),(352,15,'2018-11-03',12,'Everton','Brighton & Hove Albion','3-1',38966,103,NULL),(353,15,'2018-12-05',4,'Fulham','Leicester City','1-1',22881,146,NULL),(354,15,'2018-12-30',17,'Burnley','West Ham United','2-0',20933,198,NULL),(355,15,'2019-01-02',3,'AFC Bournemouth','Watford','3-3',10261,208,NULL),(356,15,'2019-01-29',7,'Wolverhampton Wanderers','West Ham United','3-0',31122,234,NULL),(357,15,'2019-02-26',5,'Huddersfield Town','Wolverhampton Wanderers','1-0',22714,271,NULL),(358,15,'2019-03-09',13,'Leicester City','Fulham','3-1',32017,293,NULL),(359,15,'2019-04-06',5,'Huddersfield Town','Leicester City','1-4',24126,322,NULL),(360,15,'2019-04-20',3,'AFC Bournemouth','Fulham','0-1',10511,338,NULL),(361,16,'2018-09-29',12,'Everton','Fulham','3-0',38788,63,NULL),(362,16,'2018-11-03',15,'West Ham United','Burnley','4-2',56862,105,NULL),(363,16,'2018-12-04',3,'AFC Bournemouth','Huddersfield Town','2-1',9980,141,NULL),(364,16,'2018-12-29',6,'Watford','Newcastle United','1-1',20336,195,NULL),(365,16,'2019-01-02',7,'Wolverhampton Wanderers','Crystal Palace','0-2',30666,207,NULL),(366,16,'2019-01-30',3,'AFC Bournemouth','Chelsea','4-0',10227,237,NULL),(367,16,'2019-02-23',3,'AFC Bournemouth','Wolverhampton Wanderers','1-1',10671,265,NULL),(368,16,'2019-04-02',6,'Watford','Fulham','4-1',17301,315,NULL),(369,16,'2019-04-20',5,'Huddersfield Town','Watford','1-2',23957,339,NULL),(370,16,'2019-05-12',20,'Crystal Palace','AFC Bournemouth','5-3',25433,373,NULL),(371,17,'2018-09-29',2,'Newcastle United','Leicester City','0-2',51523,66,NULL),(372,17,'2018-11-10',9,'Southampton','Watford','1-1',28153,115,NULL),(373,17,'2018-12-15',7,'Wolverhampton Wanderers','AFC Bournemouth','2-0',30997,166,NULL),(374,17,'2018-12-29',13,'Leicester City','Cardiff City','0-1',32047,193,NULL),(375,17,'2019-01-19',3,'AFC Bournemouth','West Ham United','2-0',10495,222,NULL),(376,17,'2019-02-02',19,'Brighton & Hove Albion','Watford','0-0',30414,242,NULL),(377,17,'2019-02-22',11,'Cardiff City','Watford','1-5',30387,262,NULL),(378,17,'2019-04-27',6,'Watford','Wolverhampton Wanderers','1-2',20323,356,NULL),(379,18,'2018-12-15',6,'Watford','Cardiff City','3-2',20032,165,NULL),(380,18,'2018-12-29',19,'Brighton & Hove Albion','Everton','1-0',30597,191,NULL);
/*!40000 ALTER TABLE `match` ENABLE KEYS */;
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
-- Table structure for table `odds`
--

DROP TABLE IF EXISTS `odds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odds` (
  `odds_id` int NOT NULL AUTO_INCREMENT,
  `under_odds` int DEFAULT NULL,
  `over_odds` int DEFAULT NULL,
  PRIMARY KEY (`odds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odds`
--

LOCK TABLES `odds` WRITE;
/*!40000 ALTER TABLE `odds` DISABLE KEYS */;
INSERT INTO `odds` VALUES (1,1,10),(2,5,2),(3,2,4),(4,2,3),(5,7,2),(6,2,3),(7,3,3),(8,1,10),(9,2,4),(10,4,2),(11,3,3),(12,2,4),(13,2,4),(14,1,10),(15,2,3),(16,2,4),(17,2,3),(18,1,10),(19,5,2),(20,7,1),(21,10,1),(22,3,3),(23,2,7),(24,2,4),(25,2,3),(26,1,10),(27,2,3),(28,2,3),(29,5,2),(30,2,4),(31,6,2),(32,2,4),(33,1,10),(34,2,4),(35,2,8),(36,3,3),(37,1,10),(38,6,2),(39,6,2),(40,5,2),(41,3,2),(42,2,3),(43,1,22),(44,3,2),(45,1,29),(46,5,2),(47,5,2),(48,2,6),(49,2,4),(50,2,4),(51,3,3),(52,3,2),(53,20,1),(54,2,4),(55,2,6),(56,1,16),(57,2,6),(58,5,2),(59,6,2),(60,1,7),(61,4,2),(62,1,7),(63,2,5),(64,6,2),(65,1,33),(66,3,3),(67,2,5),(68,3,3),(69,3,3),(70,2,3),(71,3,3),(72,2,4),(73,3,3),(74,2,3),(75,1,15),(76,2,4),(77,1,8),(78,5,2),(79,6,2),(80,3,3),(81,2,5),(82,2,3),(83,2,3),(84,1,34),(85,2,4),(86,4,2),(87,2,6),(88,11,1),(89,2,5),(90,2,6),(91,3,2),(92,3,2),(93,1,30),(94,2,4),(95,2,5),(96,2,3),(97,10,1),(98,5,2),(99,2,5),(100,5,2),(101,4,2),(102,3,2),(103,2,7),(104,3,3),(105,2,6),(106,4,2),(107,4,2),(108,1,23),(109,1,10),(110,2,3),(111,3,3),(112,3,2),(113,2,7),(114,3,2),(115,2,3),(116,5,2),(117,1,22),(118,1,8),(119,2,6),(120,1,8),(121,3,3),(122,1,8),(123,3,3),(124,1,8),(125,6,2),(126,12,1),(127,3,3),(128,4,2),(129,2,8),(130,3,3),(131,4,2),(132,2,7),(133,2,3),(134,2,3),(135,1,20),(136,2,3),(137,4,2),(138,1,14),(139,3,3),(140,1,7),(141,2,5),(142,3,3),(143,2,6),(144,9,1),(145,12,1),(146,3,3),(147,6,2),(148,2,8),(149,2,3),(150,1,10),(151,7,1),(152,1,12),(153,3,3),(154,3,2),(155,1,8),(156,2,3),(157,4,2),(158,4,2),(159,3,3),(160,2,5),(161,1,13),(162,3,3),(163,3,3),(164,1,17),(165,2,6),(166,2,4),(167,3,2),(168,8,1),(169,4,2),(170,2,6),(171,7,2),(172,1,15),(173,2,4),(174,1,10),(175,3,3),(176,1,21),(177,2,4),(178,2,3),(179,6,2),(180,3,2),(181,3,3),(182,4,2),(183,2,6),(184,10,1),(185,1,18),(186,1,10),(187,1,9),(188,6,2),(189,5,2),(190,2,3),(191,3,2),(192,2,4),(193,2,8),(194,1,8),(195,2,6),(196,1,8),(197,5,2),(198,4,2),(199,12,1),(200,1,7),(201,2,4),(202,1,9),(203,8,1),(204,1,12),(205,2,4),(206,2,4),(207,2,4),(208,3,3),(209,6,2),(210,2,4),(211,4,2),(212,10,1),(213,2,3),(214,2,4),(215,2,3),(216,2,4),(217,1,18),(218,2,5),(219,2,4),(220,1,18),(221,2,4),(222,2,3),(223,1,16),(224,1,8),(225,2,4),(226,3,3),(227,2,6),(228,3,2),(229,22,1),(230,6,2),(231,1,14),(232,2,3),(233,4,2),(234,2,4),(235,1,10),(236,16,1),(237,5,2),(238,2,3),(239,1,12),(240,2,6),(241,1,9),(242,2,3),(243,2,3),(244,1,14),(245,2,4),(246,3,3),(247,3,2),(248,4,2),(249,1,10),(250,9,1),(251,10,1),(252,5,2),(253,2,4),(254,5,2),(255,1,16),(256,2,5),(257,2,3),(258,2,4),(259,2,6),(260,2,6),(261,2,5),(262,3,2),(263,2,4),(264,6,2),(265,3,3),(266,2,5),(267,2,4),(268,2,6),(269,4,2),(270,4,2),(271,5,2),(272,2,5),(273,2,4),(274,1,7),(275,2,4),(276,3,2),(277,2,3),(278,1,12),(279,1,19),(280,2,4),(281,13,1),(282,2,5),(283,3,3),(284,1,7),(285,2,7),(286,2,4),(287,3,3),(288,7,1),(289,6,2),(290,2,5),(291,3,2),(292,3,2),(293,2,6),(294,3,3),(295,4,2),(296,1,24),(297,1,20),(298,2,7),(299,2,3),(300,2,4),(301,3,2),(302,2,6),(303,4,2),(304,4,2),(305,20,1),(306,3,3),(307,3,2),(308,2,8),(309,2,5),(310,1,8),(311,3,3),(312,9,1),(313,2,6),(314,1,9),(315,2,5),(316,4,2),(317,1,12),(318,2,7),(319,1,31),(320,9,1),(321,2,4),(322,6,2),(323,3,3),(324,3,2),(325,1,13),(326,2,6),(327,1,16),(328,2,4),(329,2,5),(330,5,2),(331,3,3),(332,1,8),(333,10,1),(334,2,5),(335,3,2),(336,2,5),(337,1,11),(338,2,5),(339,4,2),(340,3,2),(341,2,6),(342,2,3),(343,3,2),(344,1,7),(345,16,1),(346,1,15),(347,2,3),(348,1,14),(349,3,3),(350,7,2),(351,1,43),(352,1,8),(353,3,3),(354,2,3),(355,2,4),(356,3,3),(357,2,4),(358,3,3),(359,18,1),(360,3,3),(361,2,6),(362,6,2),(363,2,3),(364,2,7),(365,3,3),(366,9,1),(367,1,10),(368,11,1),(369,1,12),(370,1,14),(371,15,1),(372,3,2),(373,2,4),(374,3,3),(375,2,3),(376,1,9),(377,1,10),(378,1,8),(379,2,4),(380,2,3);
/*!40000 ALTER TABLE `odds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
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
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`team_name`) REFERENCES `team` (`t_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_ibfk_2` FOREIGN KEY (`nationality`) REFERENCES `country` (`c_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_ibfk_3` FOREIGN KEY (`player_stats`) REFERENCES `stats` (`stats_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Aaron Cresswell','England','Defender',32,'West Ham United',1),(2,'Aaron Lennon','England','Midfielder',35,'Burnley',2),(3,'Aaron Mooy','Australia','Midfielder',32,'Huddersfield Town',3),(4,'Aaron Ramsey','Wales','Midfielder',31,'Arsenal',4),(5,'Aaron Rowe','England','Forward',22,'Huddersfield Town',5),(6,'Aaron Wan-Bissaka','England','Midfielder',24,'Crystal Palace',6),(7,'Abdelhamid Sabiri','Morocco','Midfielder',25,'Huddersfield Town',7),(8,'Abdoulaye Doucouré','France','Midfielder',29,'Watford',8),(9,'Aboubakar Kamara','France','Forward',27,'Fulham',9),(10,'Adalberto Peñaranda Maestre','Venezuela','Forward',25,'Watford',10),(11,'Adam Lallana','England','Midfielder',34,'Liverpool',11),(12,'Adam Masina','Italy','Defender',28,'Watford',12),(13,'Adam Smith','England','Defender',31,'AFC Bournemouth',13),(14,'Adama Diakhaby','France','Forward',26,'Huddersfield Town',14),(15,'Adama Traoré','Spain','Midfielder',26,'Wolverhampton Wanderers',15),(16,'Ademola Lookman','England','Forward',25,'Everton',16),(17,'Adrián','Spain','Goalkeeper',35,'West Ham United',17),(18,'Adrian Mariappa','Jamaica','Defender',36,'Watford',18),(19,'Adrien Sebastian Perruchet Silva','Portugal','Midfielder',33,'Leicester City',19),(20,'Ainsley Maitland-Niles','England','Midfielder',25,'Arsenal',20),(21,'Alberto Moreno','Spain','Defender',30,'Liverpool',21),(22,'Aleksandar Mitrović','Serbia','Forward',28,'Fulham',22),(23,'Alex Iwobi','Nigeria','Forward',26,'Arsenal',23),(24,'Alex McCarthy','England','Goalkeeper',32,'Southampton',24),(25,'Alex Oxlade-Chamberlain','England','Midfielder',29,'Liverpool',25),(26,'Alex Pritchard','England','Midfielder',29,'Huddersfield Town',26),(27,'Alex Smithies','England','Goalkeeper',32,'Cardiff City',27),(28,'Alexander Sørloth','Norway','Forward',26,'Crystal Palace',28),(29,'Alexandre Lacazette','France','Forward',31,'Arsenal',29),(30,'Alexandre Nascimento Costa Silva','Portugal','Forward',25,'West Ham United',30),(31,'Alexis Sanchez','Chile','Forward',33,'Manchester United',31),(32,'Alfie Jones','England','Defender',25,'Southampton',32),(33,'Alfie Mawson','England','Defender',28,'Fulham',33),(34,'Alfie Whiteman','England','Goalkeeper',24,'Tottenham Hotspur',34),(35,'Ali Koiki','England','Defender',22,'Burnley',35),(36,'Alireza Jahanbakhsh','Iran','Forward',29,'Brighton & Hove Albion',36),(37,'Alisson Becker','Brazil','Goalkeeper',30,'Liverpool',37),(38,'Alvaro Morata','Spain','Forward',30,'Chelsea',38),(39,'Ander Herrera','Spain','Midfielder',33,'Manchester United',39),(40,'André Gomes','Portugal','Midfielder',29,'Everton',40),(41,'Andre Gray','England','Forward',31,'Watford',41),(42,'André Schürrle','Germany','Midfielder',31,'Fulham',42),(43,'André-Frank Zambo Anguissa','Cameroon','Midfielder',26,'Fulham',43),(44,'Andreas Christensen','Denmark','Defender',26,'Chelsea',44),(45,'Andreas Pereira','Brazil','Midfielder',26,'Manchester United',45),(46,'Andrew Robertson','Scotland','Defender',28,'Liverpool',46),(47,'Andrew Surman','England','Midfielder',36,'AFC Bournemouth',47),(48,'Andriy Yarmolenko','Ukraine','Forward',33,'West Ham United',48),(49,'Andros Townsend','England','Midfielder',31,'Crystal Palace',49),(50,'Andy Carroll','England','Forward',33,'West Ham United',50),(51,'Angel Gomes','England','Midfielder',22,'Manchester United',51),(52,'Angelo Ogbonna','Italy','Defender',34,'West Ham United',52),(53,'Angus Gunn','England','Goalkeeper',26,'Southampton',53),(54,'Anthony Driscoll-Glennon','England','Defender',22,'Burnley',54),(55,'Anthony Knockaert','France','Midfielder',30,'Brighton & Hove Albion',55),(56,'Anthony Martial','France','Forward',26,'Manchester United',56),(57,'Antonio Barreca','Italy','Defender',27,'Newcastle United',57),(58,'Antonio Rüdiger','Germany','Defender',29,'Chelsea',58),(59,'Antonio Valencia','Ecuador','Defender',37,'Manchester United',59),(60,'Arijanet Muric','Montenegro','Goalkeeper',23,'Manchester City',60),(61,'Aron Einar Gunnarsson','Iceland','Midfielder',33,'Cardiff City',61),(62,'Arthur Masuaku','France','Defender',28,'West Ham United',62),(63,'Artur Boruc','Poland','Goalkeeper',42,'AFC Bournemouth',63),(64,'Ashley Barnes','England','Forward',32,'Burnley',64),(65,'Ashley Westwood','England','Midfielder',32,'Burnley',65),(66,'Ashley Young','England','Midfielder',37,'Manchester United',66),(67,'Asmir Begović','Bosnia and Herzegovina','Goalkeeper',35,'AFC Bournemouth',67),(68,'Aymeric Laporte','France','Defender',28,'Manchester City',68),(69,'Ayoze Perez','Spain','Forward',29,'Newcastle United',69),(70,'Bakary Sako','Mali','Midfielder',34,'Crystal Palace',70),(71,'Ben Chilwell','England','Defender',25,'Leicester City',71),(72,'Ben Davies','Wales','Defender',29,'Tottenham Hotspur',72),(73,'Ben Foster','England','Goalkeeper',39,'Watford',73),(74,'Ben Gibson','England','Defender',29,'Burnley',74),(75,'Ben Hamer','England','Goalkeeper',34,'Huddersfield Town',75),(76,'Ben Johnson','England','Forward',22,'West Ham United',76),(77,'Ben Mee','England','Defender',33,'Burnley',77),(78,'Ben White','England','Defender',25,'Brighton & Hove Albion',78),(79,'Ben Wilmot','England','Defender',23,'Watford',79),(80,'Benjamin Mendy','France','Defender',28,'Manchester City',80),(81,'Beram Kayal','Israel','Midfielder',34,'Brighton & Hove Albion',81),(82,'Bernard Anício Caldeira Duarte','Brazil','Midfielder',30,'Everton',82),(83,'Bernardo','Brazil','Defender',27,'Brighton & Hove Albion',83),(84,'Bernardo Silva','Portugal','Midfielder',28,'Manchester City',84),(85,'Bernd Leno','Germany','Goalkeeper',30,'Arsenal',85),(86,'Bobby Reid','England','Midfielder',29,'Cardiff City',86),(87,'Brian Murphy','Republic of Ireland','Goalkeeper',39,'Cardiff City',87),(88,'Bright Enobakhare','England','Forward',24,'Wolverhampton Wanderers',88),(89,'Bruno Écuélé Manga','Gabon','Defender',34,'Cardiff City',89),(90,'Bruno Saltor Grau','Spain','Defender',42,'Brighton & Hove Albion',90),(91,'Caglar Söyüncü','Turkey','Defender',26,'Leicester City',91),(92,'Callum Hudson-Odoi','England','Midfielder',21,'Chelsea',92),(93,'Callum Paterson','Scotland','Defender',28,'Cardiff City',93),(94,'Callum Roberts','England','Forward',25,'Newcastle United',94),(95,'Callum Slattery','England','Midfielder',23,'Southampton',95),(96,'Callum Wilson','England','Forward',30,'AFC Bournemouth',96),(97,'Calum Chambers','England','Defender',27,'Fulham',97),(98,'Cameron John','England','Defender',23,'Wolverhampton Wanderers',98),(99,'Carl Jenkinson','England','Defender',30,'Arsenal',99),(100,'Carlos Sánchez','Colombia','Midfielder',36,'West Ham United',100),(101,'Cedric Soares','Portugal','Defender',31,'Southampton',101),(102,'Cenk Tosun','Turkey','Forward',31,'Everton',102),(103,'Cesar Azpilicueta','Spain','Defender',33,'Chelsea',103),(104,'Cesc Fabregas','Spain','Midfielder',35,'Chelsea',104),(105,'Charlie Austin','England','Forward',33,'Southampton',105),(106,'Charlie Daniels','England','Defender',36,'AFC Bournemouth',106),(107,'Charlie Taylor','England','Defender',29,'Burnley',107),(108,'Cheikhou Kouyaté','Senegal','Midfielder',32,'Crystal Palace',108),(109,'Chris Löwe','Germany','Defender',33,'Huddersfield Town',109),(110,'Chris Mepham','Wales','Defender',24,'AFC Bournemouth',110),(111,'Chris Smalling','England','Defender',32,'Manchester United',111),(112,'Chris Wood','New Zealand','Forward',30,'Burnley',112),(113,'Christian Atsu Twasam','Ghana','Midfielder',30,'Newcastle United',113),(114,'Christian Benteke','Belgium','Forward',31,'Crystal Palace',114),(115,'Christian Eriksen','Denmark','Midfielder',30,'Tottenham Hotspur',115),(116,'Christian Fuchs','Austria','Defender',36,'Leicester City',116),(117,'Christian Kabasele','Belgium','Defender',31,'Watford',117),(118,'Christopher Schindler','Germany','Defender',32,'Huddersfield Town',118),(119,'Ciaran Clark','Republic of Ireland','Defender',33,'Newcastle United',119),(120,'Claudio Bravo','Chile','Goalkeeper',39,'Manchester City',120),(121,'Collin Quaner','Germany','Forward',31,'Huddersfield Town',121),(122,'Connor Wickham','England','Forward',29,'Crystal Palace',122),(123,'Conor Coady','England','Midfielder',29,'Wolverhampton Wanderers',123),(124,'Conor Coventry','Republic of Ireland','Midfielder',22,'West Ham United',124),(125,'Craig Cathcart','Northern Ireland','Defender',33,'Watford',125),(126,'Curtis Jones','England','Midfielder',21,'Liverpool',126),(127,'Cyrus Christie','Republic of Ireland','Defender',30,'Fulham',127),(128,'Dale Stephens','England','Midfielder',33,'Brighton & Hove Albion',128),(129,'Dan Burn','England','Defender',30,'Brighton & Hove Albion',129),(130,'Dan Gosling','England','Midfielder',32,'AFC Bournemouth',130),(131,'Daniel Amartey','Ghana','Midfielder',27,'Leicester City',131),(132,'Daniel Sturridge','England','Forward',33,'Liverpool',132),(133,'Daniel Williams','USA','Midfielder',33,'Huddersfield Town',133),(134,'Danilo','Brazil','Defender',31,'Manchester City',134),(135,'Danny Drinkwater','England','Midfielder',32,'Chelsea',135),(136,'Danny Ings','England','Forward',30,'Southampton',136),(137,'Danny Rose','England','Defender',32,'Tottenham Hotspur',137),(138,'Danny Simpson','England','Defender',35,'Leicester City',138),(139,'Danny Ward','Wales','Goalkeeper',29,'Leicester City',139),(140,'Danny Ward','England','Forward',31,'Cardiff City',140),(141,'Danny Welbeck','England','Forward',31,'Arsenal',141),(142,'Daryl Janmaat','Netherlands','Defender',33,'Watford',142),(143,'David Brooks','England','Forward',25,'AFC Bournemouth',143),(144,'David Button','England','Goalkeeper',33,'Brighton & Hove Albion',144),(145,'David de Gea','Spain','Goalkeeper',31,'Manchester United',145),(146,'David Junior Hoilett','Canada','Forward',32,'Cardiff City',146),(147,'David Luiz','Brazil','Defender',35,'Chelsea',147),(148,'David Silva','Spain','Midfielder',36,'Manchester City',148),(149,'Davide Zappacosta','Italy','Defender',30,'Chelsea',149),(150,'Davinson Sánchez','Colombia','Defender',26,'Tottenham Hotspur',150),(151,'Davy Pröpper','Netherlands','Midfielder',31,'Brighton & Hove Albion',151),(152,'DeAndre Yedlin','USA','Defender',29,'Newcastle United',152),(153,'Declan Rice','Republic of Ireland','Midfielder',23,'West Ham United',153),(154,'Dejan Lovren','Croatia','Defender',33,'Liverpool',154),(155,'Dele Alli','England','Midfielder',26,'Tottenham Hotspur',155),(156,'Demarai Gray','England','Midfielder',26,'Leicester City',156),(157,'Demeaco Duhaney','England','Defender',24,'Huddersfield Town',157),(158,'Denis Odoi','Belgium','Defender',34,'Fulham',158),(159,'Denis Suárez','Spain','Midfielder',28,'Arsenal',159),(160,'Diego Rico','Spain','Defender',29,'AFC Bournemouth',160),(161,'Diogo Dalot','Portugal','Defender',23,'Manchester United',161),(162,'Diogo José Teixeira da Silva','Portugal','Midfielder',25,'Wolverhampton Wanderers',162),(163,'Divock Origi','Belgium','Forward',27,'Liverpool',163),(164,'Domingos Quina','Portugal','Midfielder',22,'Watford',164),(165,'Dominic Calvert-Lewin','England','Forward',25,'Everton',165),(166,'Dominic Solanke','England','Forward',25,'AFC Bournemouth',166),(167,'Dwight McNeil','England','Forward',22,'Burnley',167),(168,'Eden Hazard','Belgium','Midfielder',31,'Chelsea',168),(169,'Ederson','Brazil','Goalkeeper',29,'Manchester City',169),(170,'Edward Nketiah','England','Forward',23,'Arsenal',170),(171,'Elias Kachunga','Congo DR','Forward',30,'Huddersfield Town',171),(172,'Emerson Hyndman','USA','Midfielder',26,'AFC Bournemouth',172),(173,'Emerson Palmieri','Italy','Defender',28,'Chelsea',173),(174,'Emile Smith Rowe','England','Midfielder',22,'Arsenal',174),(175,'Emiliano Martínez','Argentina','Goalkeeper',30,'Arsenal',175),(176,'Eric Bailly','Ivory Coast','Defender',28,'Manchester United',176),(177,'Eric Dier','England','Midfielder',28,'Tottenham Hotspur',177),(178,'Erik Durm','Germany','Defender',30,'Huddersfield Town',178),(179,'Erik Lamela','Argentina','Midfielder',30,'Tottenham Hotspur',179),(180,'Ethan Ampadu','Wales','Midfielder',22,'Chelsea',180),(181,'Étienne Capoue','France','Midfielder',34,'Watford',181),(182,'Fabián Balbuena','Paraguay','Defender',31,'West Ham United',182),(183,'Fabian Delph','England','Midfielder',32,'Manchester City',183),(184,'Fabian Schär','Switzerland','Defender',30,'Newcastle United',184),(185,'Fabinho','Brazil','Midfielder',29,'Liverpool',185),(186,'Fabricio Martín Agosto Ramírez','Spain','Goalkeeper',34,'Fulham',186),(187,'Faustino Marcos Alberto Rojo','Argentina','Defender',32,'Manchester United',187),(188,'Federico Fernández','Argentina','Defender',33,'Newcastle United',188),(189,'Felipe Anderson','Brazil','Midfielder',29,'West Ham United',189),(190,'Fernandinho','Brazil','Midfielder',37,'Manchester City',190),(191,'Fernando Llorente Torres','Spain','Forward',37,'Tottenham Hotspur',191),(192,'Florent Hadergjonaj','Switzerland','Defender',28,'Huddersfield Town',192),(193,'Florian Lejeune','France','Defender',31,'Newcastle United',193),(194,'Florin Andone','Romania','Forward',29,'Brighton & Hove Albion',194),(195,'Floyd Ayité','Togo','Midfielder',33,'Fulham',195),(196,'Fousseni Diabaté','Mali','Midfielder',27,'Leicester City',196),(197,'Fraser Forster','England','Goalkeeper',34,'Southampton',197),(198,'Fred','Brazil','Midfielder',29,'Manchester United',198),(199,'Freddie Woodman','England','Goalkeeper',25,'Newcastle United',199),(200,'Gabriel Jesus','Brazil','Forward',25,'Manchester City',200),(201,'Gaëtan Bong Songo','Cameroon','Defender',34,'Brighton & Hove Albion',201),(202,'Gary Cahill','England','Defender',36,'Chelsea',202),(203,'Gary Madine','England','Forward',32,'Cardiff City',203),(204,'George Marsh','England','Midfielder',23,'Tottenham Hotspur',204),(205,'Georges-Kevin N\'Koudou Mbida','France','Forward',27,'Tottenham Hotspur',205),(206,'Georginio Wijnaldum','Netherlands','Midfielder',31,'Liverpool',206),(207,'Gerard Deulofeu','Spain','Forward',28,'Watford',207),(208,'Glenn Murray','England','Forward',39,'Brighton & Hove Albion',208),(209,'Gonzalo Higuain','Argentina','Forward',34,'Chelsea',209),(210,'Grady Diangana','England','Midfielder',24,'West Ham United',210),(211,'Granit Xhaka','Switzerland','Midfielder',30,'Arsenal',211),(212,'Greg Cunningham','Republic of Ireland','Defender',31,'Cardiff City',212),(213,'Gylfi Sigurdsson','Iceland','Midfielder',33,'Everton',213),(214,'Hamza Choudhury','England','Midfielder',25,'Leicester City',214),(215,'Harry Arter','Republic of Ireland','Midfielder',32,'Cardiff City',215),(216,'Harry Kane','England','Forward',29,'Tottenham Hotspur',216),(217,'Harry Maguire','England','Defender',29,'Leicester City',217),(218,'Harry Winks','England','Midfielder',26,'Tottenham Hotspur',218),(219,'Harvey Barnes','England','Midfielder',24,'Leicester City',219),(220,'Håvard Nordtveit','Norway','Midfielder',32,'Fulham',220),(221,'Hector Bellerin','Spain','Defender',27,'Arsenal',221),(222,'Hélder Wander Sousa Azevedo Costa','Portugal','Midfielder',28,'Wolverhampton Wanderers',222),(223,'Henrikh Mkhitaryan','Armenia','Midfielder',33,'Arsenal',223),(224,'Heung-Min Son','South Korea','Forward',30,'Tottenham Hotspur',224),(225,'Heurelho da Silva Gomes','Brazil','Goalkeeper',41,'Watford',225),(226,'Hugo Lloris','France','Goalkeeper',35,'Tottenham Hotspur',226),(227,'Ibrahima Cissé','Belgium','Midfielder',28,'Fulham',227),(228,'Idrissa Gueye','Senegal','Midfielder',33,'Everton',228),(229,'İlkay Gündoğan','Germany','Midfielder',32,'Manchester City',229),(230,'Isaac Hayden','England','Midfielder',27,'Newcastle United',230),(231,'Isaac Mbenza','Belgium','Forward',26,'Huddersfield Town',231),(232,'Isaac Success','Nigeria','Forward',26,'Watford',232),(233,'Issa Diop','France','Defender',25,'West Ham United',233),(234,'Ivan Ricardo Neves Abreu Cavaleiro','Portugal','Forward',29,'Wolverhampton Wanderers',234),(235,'Jack Cork','England','Midfielder',33,'Burnley',235),(236,'Jack Simpson','England','Defender',25,'AFC Bournemouth',236),(237,'Jack Stephens','England','Defender',28,'Southampton',237),(238,'Jack Wilshere','England','Midfielder',30,'West Ham United',238),(239,'Jacob Murphy','England','Midfielder',27,'Newcastle United',239),(240,'Jaïro Riedewald','Netherlands','Defender',26,'Crystal Palace',240),(241,'Jamaal Lascelles','England','Defender',28,'Newcastle United',241),(242,'James Garner','England','Defender',21,'Manchester United',242),(243,'James Maddison','England','Midfielder',25,'Leicester City',243),(244,'James McArthur','Scotland','Midfielder',35,'Crystal Palace',244),(245,'James McCarthy','Republic of Ireland','Midfielder',31,'Everton',245),(246,'James Milner','England','Midfielder',36,'Liverpool',246),(247,'James Tarkowski','England','Defender',29,'Burnley',247),(248,'James Tomkins','England','Defender',33,'Crystal Palace',248),(249,'James Ward-Prowse','England','Midfielder',27,'Southampton',249),(250,'Jamie Sterry','England','Defender',26,'Newcastle United',250),(251,'Jamie Vardy','England','Forward',35,'Leicester City',251),(252,'Jan Bednarek','Poland','Defender',26,'Southampton',252),(253,'Jan Vertonghen','Belgium','Defender',35,'Tottenham Hotspur',253),(254,'Jannik Vestergaard','Denmark','Defender',30,'Southampton',254),(255,'Jason Puncheon','England','Midfielder',36,'Huddersfield Town',255),(256,'Jason Steele','England','Goalkeeper',32,'Brighton & Hove Albion',256),(257,'Javier Hernandez','Mexico','Forward',34,'West Ham United',257),(258,'Javier Manquillo','Spain','Defender',28,'Newcastle United',258),(259,'Jayson Molumby','Republic of Ireland','Midfielder',23,'Brighton & Hove Albion',259),(260,'Jazz Richards','Wales','Defender',31,'Cardiff City',260),(261,'Jean Michau00ebl Seri','Ivory Coast','Midfielder',31,'Fulham',261),(262,'Jeff Hendrick','Republic of Ireland','Midfielder',30,'Burnley',262),(263,'Jefferson Lerma','Colombia','Midfielder',28,'AFC Bournemouth',263),(264,'Jeffrey Schlupp','Ghana','Defender',29,'Crystal Palace',264),(265,'Jermain Defoe','England','Forward',40,'AFC Bournemouth',265),(266,'Jesse Lingard','England','Midfielder',29,'Manchester United',266),(267,'João Moutinho','Portugal','Midfielder',36,'Wolverhampton Wanderers',267),(268,'Joe Bennett','England','Defender',32,'Cardiff City',268),(269,'Joe Bryan','England','Defender',29,'Fulham',269),(270,'Joe Daniel Tupper','England','Goalkeeper',24,'Crystal Palace',270),(271,'Joe Gomez','England','Defender',25,'Liverpool',271),(272,'Joe Hart','England','Goalkeeper',35,'Burnley',272),(273,'Joe Powell','England','Forward',24,'West Ham United',273),(274,'Joe Ralls','England','Midfielder',29,'Cardiff City',274),(275,'Joel Coleman','England','Goalkeeper',27,'Huddersfield Town',275),(276,'Joel Matip','Cameroon','Defender',31,'Liverpool',276),(277,'Joel Ward','England','Defender',32,'Crystal Palace',277),(278,'Johann Berg Guðmunds­son','Iceland','Midfielder',32,'Burnley',278),(279,'John Ruddy','England','Goalkeeper',36,'Wolverhampton Wanderers',279),(280,'John Stones','England','Defender',28,'Manchester City',280),(281,'Jon Gorenc Stankovič','Slovenia','Defender',26,'Huddersfield Town',281),(282,'Jonas Lössl','Denmark','Goalkeeper',33,'Huddersfield Town',282),(283,'Jonathan Hogg','England','Midfielder',33,'Huddersfield Town',283),(284,'Jonathan Walters','Republic of Ireland','Forward',39,'Burnley',284),(285,'Jonjo Shelvey','England','Midfielder',30,'Newcastle United',285),(286,'Jonjoe Kenny','England','Defender',25,'Everton',286),(287,'Jonny','Spain','Defender',28,'Wolverhampton Wanderers',287),(288,'Jonny Evans','Northern Ireland','Defender',34,'Leicester City',288),(289,'Jordan Ayew','Ghana','Forward',31,'Crystal Palace',289),(290,'Jordan Henderson','England','Midfielder',32,'Liverpool',290),(291,'Jordan Pickford','England','Goalkeeper',28,'Everton',291),(292,'Jordon Ibe','England','Midfielder',26,'AFC Bournemouth',292),(293,'Jorginho','Italy','Midfielder',30,'Chelsea',293),(294,'José Holebas','Greece','Defender',38,'Watford',294),(295,'Jose Izquierdo','Colombia','Forward',30,'Brighton & Hove Albion',295),(296,'Joselu','Spain','Forward',32,'Newcastle United',296),(297,'Joseph Willock','England','Midfielder',23,'Arsenal',297),(298,'Josh Benson','England','Midfielder',22,'Burnley',298),(299,'Josh Knight','England','Defender',25,'Leicester City',299),(300,'Josh Murphy','England','Forward',27,'Cardiff City',300),(301,'Joshua King','Norway','Forward',30,'AFC Bournemouth',301),(302,'Joshua Sims','England','Midfielder',25,'Southampton',302),(303,'Juan Foyth','Argentina','Defender',24,'Tottenham Hotspur',303),(304,'Juan Mata','Spain','Midfielder',34,'Manchester United',304),(305,'Julián Speroni','Argentina','Goalkeeper',43,'Crystal Palace',305),(306,'Juninho Bacuna','Netherlands','Midfielder',25,'Huddersfield Town',306),(307,'Junior Stanislas','England','Midfielder',32,'AFC Bournemouth',307),(308,'Jürgen Locadia','Netherlands','Forward',28,'Brighton & Hove Albion',308),(309,'Kadeem Harris','England','Midfielder',29,'Cardiff City',309),(310,'Karl Darlow','England','Goalkeeper',32,'Newcastle United',310),(311,'Karlan Ahearne-Grant','England','Forward',24,'Huddersfield Town',311),(312,'Kasper Schmeichel','Denmark','Goalkeeper',35,'Leicester City',312),(313,'Kayne Ramsey','England','Midfielder',22,'Southampton',313),(314,'Kazaiah Sterling','England','Forward',23,'Tottenham Hotspur',314),(315,'Kelechi Iheanacho','Nigeria','Forward',26,'Leicester City',315),(316,'Kelland Watts','England','Midfielder',23,'Newcastle United',316),(317,'Ken Sema','Sweden','Midfielder',29,'Watford',317),(318,'Kenneth Dahrup Zohorè','Denmark','Forward',28,'Cardiff City',318),(319,'Kepa Arrizabalaga','Spain','Goalkeeper',28,'Chelsea',319),(320,'Kevin De Bruyne','Belgium','Midfielder',31,'Manchester City',320),(321,'Kevin Long','Republic of Ireland','Defender',32,'Burnley',321),(322,'Kevin McDonald','Scotland','Midfielder',33,'Fulham',322),(323,'Ki Sung-yueng','South Korea','Midfielder',33,'Newcastle United',323),(324,'Kieran Dowell','England','Midfielder',25,'Everton',324),(325,'Kieran Trippier','England','Defender',32,'Tottenham Hotspur',325),(326,'Kiko Femenía','Spain','Midfielder',31,'Watford',326),(327,'Konstantinos Mavropanos','Greece','Defender',24,'Arsenal',327),(328,'Kortney Hause','England','Defender',27,'Wolverhampton Wanderers',328),(329,'Kurt Zouma','France','Defender',28,'Everton',329),(330,'Kyle Taylor','England','Midfielder',23,'AFC Bournemouth',330),(331,'Kyle Walker','England','Defender',32,'Manchester City',331),(332,'Kyle Walker-Peters','England','Defender',25,'Tottenham Hotspur',332),(333,'Laurent Depoitre','Belgium','Forward',33,'Huddersfield Town',333),(334,'Laurent Koscielny','France','Defender',37,'Arsenal',334),(335,'Lazar Marković','Serbia','Midfielder',28,'Fulham',335),(336,'Leander Dendoncker','Belgium','Midfielder',27,'Wolverhampton Wanderers',336),(337,'Leandro Bacuna','Curaçao','Midfielder',31,'Cardiff City',337),(338,'Lee Grant','England','Goalkeeper',39,'Manchester United',338),(339,'Lee Peltier','England','Defender',35,'Cardiff City',339),(340,'Leighton Baines','England','Defender',37,'Everton',340),(341,'Leon Balogun','Nigeria','Defender',34,'Brighton & Hove Albion',341),(342,'Leonardo Bonatini Lohner Maia','Brazil','Forward',28,'Wolverhampton Wanderers',342),(343,'Leroy Sané','Germany','Midfielder',26,'Manchester City',343),(344,'Lewis Cass','England','Defender',22,'Newcastle United',344),(345,'Lewis Cook','England','Midfielder',25,'AFC Bournemouth',345),(346,'Lewis Dunk','England','Defender',30,'Brighton & Hove Albion',346),(347,'Loïc Damour','France','Midfielder',31,'Cardiff City',347),(348,'Loris Karius','Germany','Goalkeeper',29,'Liverpool',348),(349,'Luca de la Torre','USA','Midfielder',24,'Fulham',349),(350,'Lucas Digne','France','Defender',29,'Everton',350),(351,'Lucas Moura','Brazil','Midfielder',30,'Tottenham Hotspur',351),(352,'Lucas Perez','Spain','Forward',34,'West Ham United',352),(353,'Lucas Torreira','Uruguay','Midfielder',26,'Arsenal',353),(354,'Luciano Vietto','Argentina','Forward',28,'Fulham',354),(355,'Luka Milivojević','Serbia','Midfielder',31,'Crystal Palace',355),(356,'Luke Amos','England','Midfielder',25,'Tottenham Hotspur',356),(357,'Luke Dreher','England','Midfielder',23,'Crystal Palace',357),(358,'Luke Shaw','England','Defender',27,'Manchester United',358),(359,'Lys Mousset','France','Forward',26,'AFC Bournemouth',359),(360,'Maarten Stekelenburg','Netherlands','Goalkeeper',40,'Everton',360),(361,'Mamadou Sakho','France','Defender',32,'Crystal Palace',361),(362,'Manolo Gabbiadini','Italy','Forward',30,'Southampton',362),(363,'Manuel Lanzini','Argentina','Midfielder',29,'West Ham United',363),(364,'Marc Albrighton','England','Midfielder',32,'Leicester City',364),(365,'Marc Guehi','England','Defender',22,'Chelsea',365),(366,'Marc Navarro Ceciliano','Spain','Defender',27,'Watford',366),(367,'Marc Pugh','England','Midfielder',35,'AFC Bournemouth',367),(368,'Marcos Alonso','Spain','Defender',31,'Chelsea',368),(369,'Marcus Bettinelli','England','Goalkeeper',30,'Fulham',369),(370,'Marcus Rashford','England','Forward',25,'Manchester United',370),(371,'Mario Lemina','Gabon','Midfielder',29,'Southampton',371),(372,'Mark Noble','England','Midfielder',35,'West Ham United',372),(373,'Mark Travers','Republic of Ireland','Goalkeeper',23,'AFC Bournemouth',373),(374,'Marko Arnautović','Austria','Forward',33,'West Ham United',374),(375,'Markus Suttner','Austria','Defender',35,'Brighton & Hove Albion',375),(376,'Marouane Fellaini','Belgium','Midfielder',34,'Manchester United',376),(377,'Martin Dúbravka','Slovakia','Goalkeeper',33,'Newcastle United',377),(378,'Martin Kelly','England','Defender',32,'Crystal Palace',378),(379,'Martín Montoya','Spain','Defender',31,'Brighton & Hove Albion',379),(380,'Mason Greenwood','England','Midfielder',21,'Manchester United',380),(381,'Mason Holgate','England','Defender',26,'Everton',381),(382,'Matěj Vydra','Czech Republic','Forward',30,'Burnley',382),(383,'Mateo Kovačić','Croatia','Midfielder',28,'Chelsea',383),(384,'Mathew Ryan','Australia','Goalkeeper',30,'Brighton & Hove Albion',384),(385,'Mathias Jørgensen','Denmark','Defender',32,'Huddersfield Town',385),(386,'Matt Butcher','England','Midfielder',25,'AFC Bournemouth',386),(387,'Matt Doherty','Republic of Ireland','Defender',30,'Wolverhampton Wanderers',387),(388,'Matt Ritchie','Scotland','Midfielder',33,'Newcastle United',388),(389,'Matt Targett','England','Defender',27,'Southampton',389),(390,'Matteo Darmian','Italy','Defender',32,'Manchester United',390),(391,'Matteo Guendouzi','France','Midfielder',23,'Arsenal',391),(392,'Matthew Connolly','England','Defender',35,'Cardiff City',392),(393,'Matthew Lowton','England','Defender',33,'Burnley',393),(394,'Matty Daly','England','Midfielder',21,'Huddersfield Town',394),(395,'Max Harrison Sanders','England','Midfielder',23,'Brighton & Hove Albion',395),(396,'Max Kilman','England','Defender',25,'Wolverhampton Wanderers',396),(397,'Max Meyer','Germany','Midfielder',27,'Crystal Palace',397),(398,'Maxime Le Marchand','France','Defender',33,'Fulham',398),(399,'Maya Yoshida','Japan','Defender',34,'Southampton',399),(400,'Mesut Özil','Germany','Midfielder',34,'Arsenal',400),(401,'Michael Keane','England','Defender',29,'Everton',401),(402,'Michael Obafemi','Republic of Ireland','Forward',22,'Southampton',402),(403,'Michail Antonio','England','Midfielder',32,'West Ham United',403),(404,'Michel Vorm','Netherlands','Goalkeeper',39,'Tottenham Hotspur',404),(405,'Michy Batshuayi','Belgium','Forward',29,'Crystal Palace',405),(406,'Miguel Almirón','Paraguay','Midfielder',28,'Newcastle United',406),(407,'Miguel Ángel Britos Cabrera','Uruguay','Defender',37,'Watford',407),(408,'Mohamed Diamé','Senegal','Midfielder',35,'Newcastle United',408),(409,'Mohamed Elneny','Egypt','Midfielder',30,'Arsenal',409),(410,'Mohamed Elyounoussi','Norway','Midfielder',28,'Southampton',410),(411,'Mohamed Salah','Egypt','Forward',30,'Liverpool',411),(412,'Morgan Gibbs-White','England','Midfielder',22,'Wolverhampton Wanderers',412),(413,'Morgan Schneiderlin','France','Midfielder',32,'Everton',413),(414,'Moussa Dembele','Belgium','Midfielder',35,'Tottenham Hotspur',414),(415,'Moussa Sissoko','France','Midfielder',33,'Tottenham Hotspur',415),(416,'N\'Golo Kanté','France','Midfielder',31,'Chelsea',416),(417,'Naby Keïta','Guinea','Midfielder',27,'Liverpool',417),(418,'Nacho Monreal','Spain','Defender',36,'Arsenal',418),(419,'Nampalys Mendy','France','Midfielder',30,'Leicester City',419),(420,'Nathan Aké','Netherlands','Defender',27,'AFC Bournemouth',420),(421,'Nathan Holland','England','Midfielder',24,'West Ham United',421),(422,'Nathan Redmond','England','Midfielder',28,'Southampton',422),(423,'Nathaniel Chalobah','England','Midfielder',27,'Watford',423),(424,'Nathaniel Clyne','England','Defender',31,'AFC Bournemouth',424),(425,'Nathaniel Mendez-Laing','England','Midfielder',30,'Cardiff City',425),(426,'Neeskens Kebano','Congo DR','Midfielder',30,'Fulham',426),(427,'Neil Leonard Dula Etheridge','Philippines','Goalkeeper',32,'Cardiff City',427),(428,'Nemanja Matić','Serbia','Midfielder',34,'Manchester United',428),(429,'Nicolas Otamendi','Argentina','Defender',34,'Manchester City',429),(430,'Nikola Tavares','England','Defender',23,'Crystal Palace',430),(431,'Nnamdi Ofoborh','England','Midfielder',22,'AFC Bournemouth',431),(432,'Oleksandr Zinchenko','Ukraine','Midfielder',25,'Manchester City',432),(433,'Oliver Skipp','England','Midfielder',22,'Tottenham Hotspur',433),(434,'Olivier Giroud','France','Forward',36,'Chelsea',434),(435,'Oriol Romeu','Spain','Midfielder',31,'Southampton',435),(436,'Oumar Niasse','Senegal','Forward',32,'Cardiff City',436),(437,'Pablo Zabaleta','Argentina','Defender',37,'West Ham United',437),(438,'Pape N\'Diaye Souaré','Senegal','Defender',32,'Crystal Palace',438),(439,'Pascal Groß','Germany','Midfielder',31,'Brighton & Hove Albion',439),(440,'Patrick van Aanholt','Netherlands','Defender',32,'Crystal Palace',440),(441,'Paul Dummett','Wales','Defender',31,'Newcastle United',441),(442,'Paul Pogba','France','Midfielder',29,'Manchester United',442),(443,'Paulo Gazzaniga','Argentina','Goalkeeper',30,'Tottenham Hotspur',443),(444,'Pedro Obiang','Equatorial Guinea','Midfielder',30,'West Ham United',444),(445,'Pedro Rodriguez','Spain','Midfielder',35,'Chelsea',445),(446,'Peter Crouch','England','Forward',41,'Burnley',446),(447,'Petr Čech','Czech Republic','Goalkeeper',40,'Arsenal',447),(448,'Phil Bardsley','Scotland','Defender',37,'Burnley',448),(449,'Phil Foden','England','Midfielder',22,'Manchester City',449),(450,'Phil Jagielka','England','Defender',40,'Everton',450),(451,'Phil Jones','England','Defender',30,'Manchester United',451),(452,'Philip Billing','Denmark','Midfielder',26,'Huddersfield Town',452),(453,'Philippe Sandler','Netherlands','Defender',25,'Manchester City',453),(454,'Pierre-Emerick Aubameyang','Gabon','Forward',33,'Arsenal',454),(455,'Pierre-Emile Højbjerg','Denmark','Midfielder',27,'Southampton',455),(456,'Rachid Ghezzal','Algeria','Forward',30,'Leicester City',456),(457,'Rafael Euclides Soares Camacho','Portugal','Midfielder',22,'Liverpool',457),(458,'Raheem Sterling','England','Forward',27,'Manchester City',458),(459,'Rajiv van La Parra','Netherlands','Midfielder',31,'Huddersfield Town',459),(460,'Ramadan Sobhi','Egypt','Forward',25,'Huddersfield Town',460),(461,'Raúl Jiménez','Mexico','Forward',31,'Wolverhampton Wanderers',461),(462,'Rhys Healey','England','Forward',27,'Cardiff City',462),(463,'Ricardo Pereira','Portugal','Defender',29,'Leicester City',463),(464,'Richarlison','Brazil','Forward',25,'Everton',464),(465,'Riyad Mahrez','Algeria','Midfielder',31,'Manchester City',465),(466,'Rob Holding','England','Defender',27,'Arsenal',466),(467,'Robbie Brady','Republic of Ireland','Midfielder',30,'Burnley',467),(468,'Robert Kenedy Nunes do Nascimento','Brazil','Midfielder',26,'Newcastle United',468),(469,'Robert Snodgrass','Scotland','Midfielder',35,'West Ham United',469),(470,'Roberto Firmino','Brazil','Forward',31,'Liverpool',470),(471,'Roberto Pereyra','Argentina','Forward',31,'Watford',471),(472,'Romain Saïss','Morocco','Midfielder',32,'Wolverhampton Wanderers',472),(473,'Romelu Lukaku','Belgium','Forward',29,'Manchester United',473),(474,'Rondon','Venezuela','Forward',33,'Newcastle United',474),(475,'Ross Barkley','England','Midfielder',28,'Chelsea',475),(476,'Ruben Loftus-Cheek','England','Midfielder',26,'Chelsea',476),(477,'Rúben Neves','Portugal','Midfielder',25,'Wolverhampton Wanderers',477),(478,'Ruben Vinagre','Portugal','Defender',23,'Wolverhampton Wanderers',478),(479,'Rui Patrício','Portugal','Goalkeeper',34,'Wolverhampton Wanderers',479),(480,'Ryan Bennett','England','Defender',32,'Wolverhampton Wanderers',480),(481,'Ryan Bertrand','England','Defender',33,'Southampton',481),(482,'Ryan Fraser','Scotland','Midfielder',28,'AFC Bournemouth',482),(483,'Ryan Fredericks','England','Midfielder',30,'West Ham United',483),(484,'Ryan Giles','England','Midfielder',22,'Wolverhampton Wanderers',484),(485,'Ryan Guno Babel','Netherlands','Forward',35,'Fulham',485),(486,'Ryan Schofield','England','Goalkeeper',22,'Huddersfield Town',486),(487,'Ryan Sessegnon','England','Defender',22,'Fulham',487),(488,'Sadio Mané','Senegal','Forward',30,'Liverpool',488),(489,'Sam Gallagher','England','Forward',27,'Southampton',489),(490,'Sam Surridge','England','Forward',24,'AFC Bournemouth',490),(491,'Sam Vokes','Wales','Forward',33,'Burnley',491),(492,'Sam Woods','England','Defender',24,'Crystal Palace',492),(493,'Samir Nasri','France','Midfielder',35,'West Ham United',493),(494,'Sandro Ramirez','Spain','Forward',27,'Everton',494),(495,'Scott Dann','England','Defender',35,'Crystal Palace',495),(496,'Scott McTominay','England','Midfielder',25,'Manchester United',496),(497,'Sead Kolašinac','Bosnia and Herzegovina','Defender',29,'Arsenal',497),(498,'Séamus Coleman','Republic of Ireland','Defender',34,'Everton',498),(499,'Sean Longstaff','England','Midfielder',25,'Newcastle United',499),(500,'Sean Morrison','England','Defender',31,'Cardiff City',500),(501,'Sebastian Prödl','Austria','Defender',35,'Watford',501),(502,'Serge Aurier','Ivory Coast','Defender',29,'Tottenham Hotspur',502),(503,'Sergio Aguero','Argentina','Forward',34,'Manchester City',503),(504,'Sergio Rico','Spain','Goalkeeper',29,'Fulham',504),(505,'Sergio Romero','Argentina','Goalkeeper',35,'Manchester United',505),(506,'Shane Duffy','Republic of Ireland','Defender',30,'Brighton & Hove Albion',506),(507,'Shane Long','Republic of Ireland','Forward',35,'Southampton',507),(508,'Shinji Okazaki','Japan','Forward',36,'Leicester City',508),(509,'Shkodran Mustafi','Germany','Defender',30,'Arsenal',509),(510,'Simon Francis','England','Defender',37,'AFC Bournemouth',510),(511,'Simon Mignolet','Belgium','Goalkeeper',34,'Liverpool',511),(512,'Sokratis Papastathopoulos','Greece','Defender',34,'Arsenal',512),(513,'Solly March','England','Midfielder',28,'Brighton & Hove Albion',513),(514,'Souleymane Bamba','Ivory Coast','Defender',37,'Cardiff City',514),(515,'Stefan Marius Johansen','Norway','Midfielder',31,'Fulham',515),(516,'Stefano Okaka','Italy','Forward',33,'Watford',516),(517,'Stephan Lichtsteiner','Switzerland','Defender',38,'Arsenal',517),(518,'Stephen Ward','Republic of Ireland','Defender',37,'Burnley',518),(519,'Steve Cook','England','Defender',31,'AFC Bournemouth',519),(520,'Steve Mounié','Benin','Forward',28,'Huddersfield Town',520),(521,'Steven Davis','Northern Ireland','Midfielder',37,'Southampton',521),(522,'Steven Defour','Belgium','Midfielder',34,'Burnley',522),(523,'Stuart Armstrong','Scotland','Midfielder',30,'Southampton',523),(524,'Sullay Kaikai','England','Midfielder',27,'Crystal Palace',524),(525,'Tahith Chong','Netherlands','Forward',22,'Manchester United',525),(526,'Terence Kongolo','Netherlands','Defender',28,'Huddersfield Town',526),(527,'Theo Walcott','England','Forward',33,'Everton',527),(528,'Tim Ream','USA','Defender',35,'Fulham',528),(529,'Timothy Eyoma','England','Defender',22,'Tottenham Hotspur',529),(530,'Timothy Fosu-Mensah','Netherlands','Defender',24,'Fulham',530),(531,'Toby Alderweireld','Belgium','Defender',33,'Tottenham Hotspur',531),(532,'Tom Cairney','Scotland','Midfielder',31,'Fulham',532),(533,'Tom Cleverley','England','Midfielder',33,'Watford',533),(534,'Tom Davies','England','Midfielder',24,'Everton',534),(535,'Tom Heaton','England','Goalkeeper',36,'Burnley',535),(536,'Tom Smith','England','Defender',30,'Huddersfield Town',536),(537,'Trent Alexander-Arnold','England','Defender',24,'Liverpool',537),(538,'Troy Deeney','England','Forward',34,'Watford',538),(539,'Tyias Browning','England','Defender',28,'Everton',539),(540,'Tyreke Johnson','England','Defender',24,'Southampton',540),(541,'Tyrone Mings','England','Defender',29,'AFC Bournemouth',541),(542,'Vicente Guaita','Spain','Goalkeeper',35,'Crystal Palace',542),(543,'Vicente Iborra De La Fuente','Spain','Midfielder',34,'Leicester City',543),(544,'Víctor Camarasa','Spain','Midfielder',28,'Cardiff City',544),(545,'Victor Lindelöf','Sweden','Defender',28,'Manchester United',545),(546,'Victor Moses','Nigeria','Midfielder',31,'Chelsea',546),(547,'Victor Wanyama','Kenya','Midfielder',31,'Tottenham Hotspur',547),(548,'Viktor Gyökeres','Sweden','Forward',24,'Brighton & Hove Albion',548),(549,'Vincent Janssen','Netherlands','Forward',28,'Tottenham Hotspur',549),(550,'Vincent Kompany','Belgium','Defender',36,'Manchester City',550),(551,'Virgil van Dijk','Netherlands','Defender',31,'Liverpool',551),(552,'Wayne Hennessey','Wales','Goalkeeper',35,'Crystal Palace',552),(553,'Wes Morgan','Jamaica','Defender',38,'Leicester City',553),(554,'Wesley Hoedt','Netherlands','Defender',28,'Southampton',554),(555,'Wilfred Ndidi','Nigeria','Midfielder',25,'Leicester City',555),(556,'Wilfried Zaha','Ivory Coast','Midfielder',29,'Crystal Palace',556),(557,'Will Hughes','England','Midfielder',27,'Watford',557),(558,'Will Norris','England','Goalkeeper',29,'Wolverhampton Wanderers',558),(559,'Willian','Brazil','Forward',34,'Chelsea',559),(560,'Willy Boly','France','Defender',31,'Wolverhampton Wanderers',560),(561,'Willy Caballero','Argentina','Goalkeeper',41,'Chelsea',561),(562,'Xherdan Shaqiri','Switzerland','Midfielder',31,'Liverpool',562),(563,'Yan Valery','France','Defender',23,'Southampton',563),(564,'Yerry Mina','Colombia','Defender',28,'Everton',564),(565,'Yoshinori Muto','Japan','Forward',30,'Newcastle United',565),(566,'Youri Tielemans','Belgium','Midfielder',25,'Leicester City',566),(567,'Yves Bissouma','Mali','Midfielder',26,'Brighton & Hove Albion',567),(568,'Zechariah Medley','England','Defender',22,'Arsenal',568),(569,'Zeze  Steven Sessegnon','England','Defender',22,'Fulham',569),(570,'Łukasz Fabiański','Poland','Goalkeeper',37,'West Ham United',570);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
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
-- Table structure for table `referee`
--

DROP TABLE IF EXISTS `referee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referee` (
  `ref_id` int NOT NULL AUTO_INCREMENT,
  `age` int DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `games_reffed` int DEFAULT NULL,
  PRIMARY KEY (`ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referee`
--

LOCK TABLES `referee` WRITE;
/*!40000 ALTER TABLE `referee` DISABLE KEYS */;
INSERT INTO `referee` VALUES (1,53,'Andre Marriner',54),(2,39,'Martin Atkinson',58),(3,32,'Kevin Friend',54),(4,44,'Mike Dean',58),(5,49,'Chris Kavanagh',48),(6,34,'Jonathan Moss',54),(7,36,'Craig Pawson',52),(8,43,'Anthony Taylor',64),(9,57,'Graham Scott',34),(10,37,'Michael Oliver',60),(11,58,'Lee Mason',38),(12,39,'Stuart Attwell',40),(13,30,'Paul Tierney',48),(14,54,'Lee Probert',36),(15,59,'David Coote',22),(16,38,'Roger East',20),(17,44,'Simon Hooper',16),(18,47,'Andy Madley',4);
/*!40000 ALTER TABLE `referee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stadium`
--

DROP TABLE IF EXISTS `stadium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stadium` (
  `stadium_id` int NOT NULL AUTO_INCREMENT,
  `stadium_name` varchar(64) NOT NULL,
  `seats` int DEFAULT NULL,
  `founded` date DEFAULT NULL,
  PRIMARY KEY (`stadium_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stadium`
--

LOCK TABLES `stadium` WRITE;
/*!40000 ALTER TABLE `stadium` DISABLE KEYS */;
INSERT INTO `stadium` VALUES (1,'Old Trafford (Manchester)',74556,'1995-10-23'),(2,'St. James\' Park (Newcastle upon Tyne)',52242,'1995-10-23'),(3,'Vitality Stadium (Bournemouth- Dorset)',10986,'1995-10-23'),(4,'Craven Cottage (London)',25401,'1995-10-23'),(5,'John Smith\'s Stadium (Huddersfield- West Yorkshire)',24263,'1995-10-23'),(6,'Vicarage Road (Watford)',20540,'1995-10-23'),(7,'Molineux Stadium (Wolverhampton- West Midlands)',31436,'1995-10-23'),(8,'Anfield (Liverpool)',53373,'1995-10-23'),(9,'St. Mary\'s Stadium (Southampton- Hampshire)',31890,'1995-10-23'),(10,'Emirates Stadium (London)',60030,'1995-10-23'),(11,'Cardiff City Stadium (Cardiff (Caerdydd))',33082,'1995-10-23'),(12,'Goodison Park (Liverpool)',39400,'1995-10-23'),(13,'King Power Stadium (Leicester- Leicestershire)',32184,'1995-10-23'),(14,'Wembley Stadium (London)',81332,'1995-10-23'),(15,'London Stadium (London)',59988,'1995-10-23'),(16,'Stamford Bridge (London)',40721,'1995-10-23'),(17,'Turf Moor (Burnley)',21741,'1995-10-23'),(18,'Etihad Stadium (Manchester)',54511,'1995-10-23'),(19,'The American Express Community Stadium (Falmer- East Sussex)',30862,'1995-10-23'),(20,'Selhurst Park (London)',25789,'1995-10-23'),(21,'Tottenham Hotspur Stadium (London)',60124,'1995-10-23');
/*!40000 ALTER TABLE `stadium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `stats_id` int NOT NULL AUTO_INCREMENT,
  `goals` int DEFAULT '0',
  `appearances` int DEFAULT '0',
  `assists` int DEFAULT '0',
  PRIMARY KEY (`stats_id`)
) ENGINE=InnoDB AUTO_INCREMENT=571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,0,20,1),(2,1,16,1),(3,3,29,1),(4,4,28,6),(5,0,2,0),(6,0,35,3),(7,0,2,0),(8,5,35,6),(9,3,13,0),(10,0,0,0),(11,0,13,0),(12,0,14,1),(13,1,25,1),(14,0,12,0),(15,1,29,1),(16,0,21,2),(17,0,0,0),(18,0,26,0),(19,0,2,0),(20,1,16,1),(21,0,2,0),(22,11,37,3),(23,3,35,6),(24,0,25,0),(25,0,2,0),(26,2,30,0),(27,0,0,0),(28,0,12,0),(29,13,35,8),(30,0,1,0),(31,1,20,3),(32,0,0,0),(33,0,15,0),(34,0,0,0),(35,0,0,0),(36,0,19,0),(37,0,38,0),(38,5,16,0),(39,2,22,3),(40,1,27,1),(41,7,29,2),(42,6,24,0),(43,0,22,0),(44,0,8,0),(45,1,15,1),(46,0,36,11),(47,0,18,0),(48,2,9,0),(49,6,38,4),(50,0,12,0),(51,0,2,0),(52,1,24,1),(53,0,12,0),(54,0,0,0),(55,2,30,6),(56,10,27,2),(57,0,1,0),(58,1,33,0),(59,0,6,0),(60,0,0,0),(61,1,28,1),(62,0,23,1),(63,0,12,0),(64,12,37,2),(65,2,34,7),(66,2,30,2),(67,0,24,0),(68,3,35,3),(69,12,37,2),(70,0,4,0),(71,0,36,4),(72,0,27,0),(73,0,38,0),(74,1,1,0),(75,0,7,0),(76,0,1,0),(77,0,38,2),(78,0,0,0),(79,0,2,0),(80,0,10,5),(81,1,18,1),(82,1,34,3),(83,0,22,1),(84,7,36,7),(85,0,32,0),(86,5,27,2),(87,0,0,0),(88,0,0,0),(89,0,38,1),(90,0,14,1),(91,0,6,0),(92,0,10,1),(93,4,27,1),(94,0,0,0),(95,0,3,0),(96,14,30,9),(97,2,31,0),(98,0,0,0),(99,0,3,0),(100,0,7,0),(101,1,18,2),(102,3,25,3),(103,1,38,5),(104,0,6,0),(105,2,25,2),(106,1,21,0),(107,0,38,1),(108,0,31,2),(109,0,29,2),(110,0,13,1),(111,1,24,0),(112,10,38,2),(113,1,28,0),(114,1,16,1),(115,8,35,12),(116,0,3,0),(117,0,21,0),(118,1,37,0),(119,3,11,0),(120,0,0,0),(121,0,2,0),(122,0,6,1),(123,0,38,0),(124,0,0,0),(125,3,36,0),(126,0,0,0),(127,0,28,1),(128,1,30,1),(129,0,0,0),(130,2,25,1),(131,0,9,0),(132,2,18,1),(133,0,5,0),(134,1,11,0),(135,0,0,0),(136,7,24,3),(137,0,26,3),(138,0,6,0),(139,0,0,0),(140,1,14,0),(141,1,8,1),(142,0,18,2),(143,7,30,5),(144,0,4,0),(145,0,38,0),(146,3,32,1),(147,3,36,2),(148,6,33,8),(149,0,4,0),(150,1,23,1),(151,1,30,1),(152,1,29,2),(153,2,34,0),(154,1,13,0),(155,5,25,3),(156,4,34,1),(157,0,1,0),(158,0,31,1),(159,0,4,0),(160,0,12,0),(161,0,16,2),(162,9,33,5),(163,3,12,1),(164,1,8,0),(165,6,35,2),(166,0,10,1),(167,3,21,5),(168,16,37,15),(169,0,38,1),(170,1,5,0),(171,0,20,0),(172,0,1,0),(173,0,10,0),(174,0,0,0),(175,0,0,0),(176,0,12,0),(177,3,20,0),(178,0,28,1),(179,4,19,2),(180,0,0,0),(181,1,33,3),(182,1,23,0),(183,0,11,1),(184,4,24,1),(185,1,28,2),(186,0,2,0),(187,0,5,0),(188,0,19,1),(189,9,36,4),(190,1,29,3),(191,1,20,4),(192,0,24,0),(193,0,12,0),(194,3,23,0),(195,1,16,0),(196,0,1,0),(197,0,1,0),(198,1,17,1),(199,0,0,0),(200,7,29,3),(201,0,22,0),(202,0,2,0),(203,0,5,0),(204,0,0,0),(205,0,1,1),(206,3,35,0),(207,10,30,5),(208,13,38,1),(209,5,14,0),(210,0,17,1),(211,4,29,2),(212,0,7,0),(213,13,38,6),(214,0,9,0),(215,0,25,1),(216,17,28,4),(217,3,31,0),(218,1,26,0),(219,1,16,2),(220,0,5,1),(221,0,19,5),(222,1,25,2),(223,6,25,4),(224,12,31,6),(225,0,0,0),(226,0,33,0),(227,0,3,0),(228,0,33,2),(229,6,31,3),(230,1,25,4),(231,1,22,1),(232,1,30,1),(233,1,33,0),(234,3,23,1),(235,1,37,2),(236,0,6,0),(237,1,24,0),(238,0,8,1),(239,0,9,1),(240,0,0,0),(241,0,32,1),(242,0,1,0),(243,7,36,7),(244,3,38,6),(245,0,1,0),(246,5,31,4),(247,3,35,1),(248,1,29,1),(249,7,26,0),(250,0,0,0),(251,18,34,4),(252,0,25,1),(253,1,22,0),(254,0,23,0),(255,0,11,0),(256,0,0,0),(257,7,25,1),(258,0,18,3),(259,0,0,0),(260,0,4,0),(261,1,32,2),(262,3,32,0),(263,2,30,0),(264,4,30,1),(265,0,4,0),(266,4,27,2),(267,1,38,8),(268,0,30,1),(269,0,28,1),(270,0,0,0),(271,0,16,0),(272,0,19,0),(273,0,0,0),(274,0,28,0),(275,0,1,0),(276,1,22,0),(277,1,7,0),(278,3,29,6),(279,0,1,0),(280,0,24,0),(281,1,11,0),(282,0,31,1),(283,0,29,1),(284,0,0,0),(285,1,16,1),(286,0,10,1),(287,1,33,1),(288,1,24,0),(289,1,20,2),(290,1,32,3),(291,0,38,0),(292,1,19,1),(293,2,37,0),(294,3,28,6),(295,0,15,1),(296,2,16,0),(297,0,2,0),(298,0,0,0),(299,0,0,0),(300,3,29,2),(301,12,35,3),(302,0,7,1),(303,1,12,0),(304,3,22,2),(305,0,1,0),(306,1,21,0),(307,2,23,3),(308,2,26,0),(309,1,13,0),(310,0,0,0),(311,4,13,0),(312,0,38,0),(313,0,1,0),(314,0,0,0),(315,1,30,3),(316,0,0,0),(317,1,17,2),(318,1,19,1),(319,0,36,0),(320,2,19,2),(321,0,6,1),(322,0,15,0),(323,0,18,1),(324,0,0,0),(325,1,27,3),(326,1,29,1),(327,0,4,0),(328,0,0,0),(329,2,32,2),(330,0,0,0),(331,1,33,1),(332,0,6,3),(333,0,23,1),(334,3,17,0),(335,0,1,0),(336,2,19,0),(337,0,11,0),(338,0,0,0),(339,0,20,0),(340,0,6,0),(341,1,8,0),(342,0,7,1),(343,10,31,10),(344,0,0,0),(345,0,13,0),(346,2,36,1),(347,0,2,0),(348,0,0,0),(349,0,0,0),(350,4,35,4),(351,10,32,0),(352,3,15,0),(353,2,34,2),(354,1,20,4),(355,12,38,2),(356,0,1,0),(357,0,1,0),(358,1,29,4),(359,1,24,0),(360,0,0,0),(361,0,27,0),(362,1,12,0),(363,1,10,1),(364,2,27,2),(365,0,0,0),(366,0,2,0),(367,0,0,0),(368,2,31,4),(369,0,7,0),(370,10,33,6),(371,1,21,1),(372,5,31,5),(373,0,2,0),(374,10,28,4),(375,0,0,0),(376,0,14,1),(377,0,38,0),(378,0,13,0),(379,0,25,1),(380,0,3,0),(381,0,5,0),(382,1,13,1),(383,0,32,2),(384,0,34,0),(385,3,24,1),(386,0,0,0),(387,4,38,5),(388,2,36,8),(389,1,16,3),(390,0,6,0),(391,0,33,0),(392,0,0,0),(393,0,21,0),(394,0,2,0),(395,0,0,0),(396,0,1,0),(397,1,29,2),(398,0,26,1),(399,0,17,1),(400,5,24,2),(401,1,33,2),(402,1,6,1),(403,6,33,4),(404,0,2,0),(405,5,11,0),(406,0,10,0),(407,0,3,0),(408,0,29,0),(409,0,8,0),(410,0,16,0),(411,22,38,8),(412,0,26,1),(413,0,14,1),(414,0,10,0),(415,0,29,3),(416,4,36,4),(417,2,25,1),(418,1,22,3),(419,0,31,0),(420,4,38,0),(421,0,0,0),(422,6,38,4),(423,0,9,0),(424,0,18,1),(425,4,20,1),(426,0,7,0),(427,0,38,0),(428,1,28,0),(429,0,18,0),(430,0,0,0),(431,0,0,0),(432,0,14,3),(433,0,8,0),(434,2,27,4),(435,1,31,0),(436,0,18,0),(437,0,26,1),(438,0,1,0),(439,3,25,3),(440,3,36,2),(441,0,26,0),(442,13,35,9),(443,0,3,0),(444,0,24,1),(445,8,31,2),(446,0,6,0),(447,0,7,0),(448,0,19,0),(449,1,13,0),(450,1,7,0),(451,0,18,1),(452,2,27,0),(453,0,0,0),(454,22,36,5),(455,4,31,3),(456,1,19,0),(457,0,1,0),(458,17,34,10),(459,0,5,0),(460,0,4,0),(461,13,38,7),(462,0,3,0),(463,2,35,6),(464,13,35,1),(465,7,27,4),(466,0,10,0),(467,0,16,1),(468,1,25,1),(469,2,33,5),(470,12,34,6),(471,6,33,1),(472,2,19,0),(473,12,32,0),(474,11,32,7),(475,3,27,5),(476,6,24,2),(477,4,35,3),(478,0,17,0),(479,0,37,0),(480,1,34,0),(481,1,24,0),(482,7,38,14),(483,1,15,0),(484,0,0,0),(485,5,16,3),(486,0,0,0),(487,2,35,6),(488,22,36,1),(489,0,4,0),(490,0,2,0),(491,3,20,0),(492,0,0,0),(493,0,5,2),(494,0,0,0),(495,0,10,1),(496,2,16,0),(497,0,24,5),(498,2,29,2),(499,1,9,0),(500,1,34,3),(501,0,1,0),(502,0,8,2),(503,21,33,8),(504,0,29,0),(505,0,0,0),(506,5,35,1),(507,5,26,1),(508,0,21,1),(509,2,31,0),(510,0,17,2),(511,0,0,0),(512,1,25,2),(513,1,35,5),(514,4,28,1),(515,0,12,0),(516,0,2,0),(517,0,14,0),(518,0,3,0),(519,1,31,1),(520,2,31,3),(521,0,3,1),(522,0,6,0),(523,3,29,2),(524,0,0,0),(525,0,2,0),(526,1,32,1),(527,5,37,2),(528,0,26,0),(529,0,0,0),(530,0,12,0),(531,0,34,0),(532,1,31,1),(533,1,13,0),(534,0,16,0),(535,0,19,0),(536,0,15,0),(537,1,29,12),(538,9,32,5),(539,0,0,0),(540,0,1,0),(541,0,5,0),(542,0,20,0),(543,0,8,0),(544,5,32,4),(545,1,30,1),(546,0,2,0),(547,1,13,0),(548,0,0,0),(549,0,3,0),(550,1,17,0),(551,4,38,2),(552,0,18,0),(553,3,22,0),(554,0,13,0),(555,2,38,0),(556,10,34,5),(557,2,32,4),(558,0,1,0),(559,3,32,6),(560,4,36,0),(561,0,2,0),(562,6,24,3),(563,2,23,1),(564,1,13,0),(565,1,17,0),(566,3,13,4),(567,0,28,0),(568,0,0,0),(569,0,0,0),(570,0,38,0);
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
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
  CONSTRAINT `team_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_2` FOREIGN KEY (`nationality`) REFERENCES `country` (`c_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_3` FOREIGN KEY (`home_stadium`) REFERENCES `stadium` (`stadium_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_4` FOREIGN KEY (`league_name`) REFERENCES `league` (`league_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES ('AFC Bournemouth',9,'England','1995-10-23',2,3,3,'Premier League'),('Arsenal',1,'England','1995-10-23',2,3,10,'Premier League'),('Brighton & Hove Albion',18,'England','1995-10-23',2,3,19,'Premier League'),('Burnley',7,'England','1995-10-23',2,3,17,'Premier League'),('Cardiff City',16,'Wales','1995-10-23',2,3,11,'Premier League'),('Chelsea',12,'England','1995-10-23',2,3,16,'Premier League'),('Crystal Palace',5,'England','1995-10-23',2,3,20,'Premier League'),('Everton',6,'England','1995-10-23',2,3,12,'Premier League'),('Fulham',17,'England','1995-10-23',2,3,4,'Premier League'),('Huddersfield Town',19,'England','1995-10-23',2,3,5,'Premier League'),('Leicester City',4,'England','1995-10-23',2,3,13,'Premier League'),('Liverpool',11,'England','1995-10-23',2,3,8,'Premier League'),('Manchester City',3,'England','1995-10-23',2,3,18,'Premier League'),('Manchester United',10,'England','1995-10-23',2,3,1,'Premier League'),('Newcastle United',15,'England','1995-10-23',2,3,2,'Premier League'),('Southampton',8,'England','1995-10-23',2,3,9,'Premier League'),('Tottenham Hotspur',2,'England','1995-10-23',2,3,21,'Premier League'),('Watford',14,'England','1995-10-23',2,3,6,'Premier League'),('West Ham United',13,'England','1995-10-23',2,3,15,'Premier League'),('Wolverhampton Wanderers',20,'England','1995-10-23',2,3,7,'Premier League');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
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

-- Dump completed on 2024-04-17 17:32:59
