-- MySQL dump 10.19  Distrib 10.3.39-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: bimashco_obspubg
-- ------------------------------------------------------
-- Server version	10.3.39-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `round_id` int(11) DEFAULT NULL,
  `uuid` text DEFAULT NULL,
  `match_name` varchar(100) DEFAULT NULL,
  `match_map` varchar(50) DEFAULT NULL,
  `match_bg_img` varchar(255) DEFAULT NULL,
  `match_start_time` time DEFAULT NULL,
  `live` tinyint(1) DEFAULT 1,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_match_round_id` (`round_id`),
  CONSTRAINT `fk_match_round_id` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` VALUES (1,1,'tonight-bang-bang','tonight bang bang','sanhok','https://cdn.mos.cms.futurecdn.net/kTvaPcCvMwbEtJugHg38v.jpg','09:00:00',0,1,'2024-01-04 15:40:45','2024-01-04 15:40:45'),(2,1,'highlander-round','Wanna move tommorow??','Omgles','West Smage ggg','03:00:00',0,1,'2024-01-08 19:21:11','2024-01-08 19:21:11'),(3,10,'match-1-ff38ba5e','Match 11','Erangle','https://i.imgur.com/4z9v5Zu.jpg','04:34:00',1,1,'2024-01-13 10:48:05','2024-01-13 10:48:05'),(4,1,'match-1-1f26b669','MATCH 1','Erangle','https://i.imgur.com/4z9v5Zu.jpg','14:00:00',1,1,'2024-01-15 13:56:45','2024-01-15 13:56:45'),(5,12,'nne-s1-969d6078','NNE S1','Sanhok','https://i.imgur.com/4z9v5Zu.jpg','13:02:00',1,1,'2024-01-20 18:29:16','2024-01-20 18:29:16');
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ongoing_player_score`
--

DROP TABLE IF EXISTS `ongoing_player_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ongoing_player_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `player_id` int(11) DEFAULT NULL,
  `current_kills` int(11) DEFAULT NULL,
  `death` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_id` (`team_id`),
  KEY `match_id` (`match_id`),
  KEY `player_id` (`player_id`),
  KEY `fk_ops_tournament_id` (`tournament_id`),
  KEY `fk_ops_round_id` (`round_id`),
  CONSTRAINT `fk_ops_round_id` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ops_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ongoing_player_score_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ongoing_player_score_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ongoing_player_score_ibfk_3` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ongoing_player_score`
--

LOCK TABLES `ongoing_player_score` WRITE;
/*!40000 ALTER TABLE `ongoing_player_score` DISABLE KEYS */;
INSERT INTO `ongoing_player_score` VALUES (284,1,1,1,1,5,0,0,'2024-01-14 10:05:13','2024-01-19 17:06:11'),(285,1,1,1,1,11,3,1,'2024-01-14 10:05:13','2024-01-25 10:57:50'),(286,1,1,1,1,20,4,1,'2024-01-14 10:05:13','2024-01-16 08:10:40'),(287,1,1,1,1,21,0,1,'2024-01-14 10:05:13','2024-01-16 08:10:43'),(288,1,1,1,2,6,3,1,'2024-01-15 04:41:28','2024-01-19 17:06:29'),(289,1,1,1,2,7,9,1,'2024-01-15 04:41:28','2024-01-19 17:06:30'),(290,1,1,1,2,9,2,1,'2024-01-15 04:41:28','2024-01-16 08:09:25'),(291,1,1,1,2,10,0,1,'2024-01-15 04:41:28','2024-01-15 16:42:50'),(300,1,1,1,3,28,0,1,'2024-01-15 05:03:07','2024-01-16 10:45:22'),(301,1,1,1,3,29,4,1,'2024-01-15 05:03:07','2024-01-16 10:45:23'),(302,1,1,1,3,30,4,1,'2024-01-15 05:03:07','2024-01-16 10:45:23'),(303,1,1,1,3,32,0,1,'2024-01-15 05:03:07','2024-01-19 15:57:29'),(304,1,1,1,4,22,0,0,'2024-01-15 05:03:32','2024-01-15 18:08:18'),(305,1,1,1,4,39,0,0,'2024-01-15 05:03:32','2024-01-15 18:13:55'),(306,1,1,1,4,40,0,0,'2024-01-15 05:03:32','2024-01-15 18:13:56'),(307,1,1,1,4,42,1,0,'2024-01-15 05:03:32','2024-01-15 18:13:57'),(308,1,1,1,5,33,0,0,'2024-01-15 05:03:48','2024-01-15 18:08:24'),(309,1,1,1,5,35,0,0,'2024-01-15 05:03:48','2024-01-15 18:13:38'),(310,1,1,1,5,36,0,0,'2024-01-15 05:03:48','2024-01-15 18:13:39'),(311,1,1,1,5,37,0,0,'2024-01-15 05:03:48','2024-01-15 18:13:40'),(312,1,1,1,6,43,0,0,'2024-01-15 05:03:56','2024-01-15 18:08:20'),(313,1,1,1,6,44,0,0,'2024-01-15 05:03:56','2024-01-15 18:13:42'),(314,1,1,1,6,45,0,0,'2024-01-15 05:03:56','2024-01-15 18:13:43'),(315,1,1,1,6,46,0,0,'2024-01-15 05:03:56','2024-01-15 18:13:44'),(316,1,1,1,7,48,3,0,'2024-01-15 05:04:03','2024-01-19 15:57:34'),(317,1,1,1,7,49,0,0,'2024-01-15 05:04:03','2024-01-15 18:13:46'),(318,1,1,1,7,50,0,0,'2024-01-15 05:04:03','2024-01-15 18:13:47'),(319,1,1,1,7,52,0,0,'2024-01-15 05:04:03','2024-01-15 18:13:47');
/*!40000 ALTER TABLE `ongoing_player_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ongoing_team_score`
--

DROP TABLE IF EXISTS `ongoing_team_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ongoing_team_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tournament_id` int(11) DEFAULT NULL,
  `round_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `kills` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `ranking` smallint(6) DEFAULT NULL,
  `slot` varchar(30) DEFAULT NULL,
  `live` tinyint(1) DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `match_id` (`match_id`),
  KEY `team_id` (`team_id`),
  KEY `fk_ots_tournament_id` (`tournament_id`),
  KEY `fk_ots_round_id` (`round_id`),
  CONSTRAINT `fk_ots_round_id` FOREIGN KEY (`round_id`) REFERENCES `rounds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ots_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ongoing_team_score_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ongoing_team_score_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ongoing_team_score`
--

LOCK TABLES `ongoing_team_score` WRITE;
/*!40000 ALTER TABLE `ongoing_team_score` DISABLE KEYS */;
INSERT INTO `ongoing_team_score` VALUES (34,1,1,1,1,69,2,70,NULL,'1',0,0,'2024-01-14 09:06:55','2024-01-25 10:57:51'),(35,1,1,1,2,14,4,145,5,'4',0,0,'2024-01-14 09:07:01','2024-01-19 17:06:31'),(36,1,1,1,3,8,4,8,7,'5',0,0,'2024-01-14 09:07:08','2024-01-19 15:57:29'),(37,1,1,1,4,1,0,1,0,'10',0,0,'2024-01-14 09:07:13','2024-01-15 18:13:57'),(38,1,1,1,5,0,0,0,0,'14',0,0,'2024-01-14 09:07:19','2024-01-15 18:13:41'),(39,1,1,1,6,0,0,0,0,'22',0,0,'2024-01-14 09:08:06','2024-01-15 18:13:45'),(40,1,1,1,7,3,0,3,0,'17',0,0,'2024-01-14 09:08:12','2024-01-19 15:57:34'),(41,1,1,2,1,69,2,70,NULL,'17',0,1,'2024-01-14 09:08:32','2024-01-25 07:55:55'),(42,1,1,2,2,0,0,0,0,'6',0,1,'2024-01-14 09:08:38','2024-01-14 09:08:38'),(43,1,1,2,3,0,0,0,0,'8',0,1,'2024-01-14 09:08:43','2024-01-14 09:08:43'),(44,1,1,2,4,0,0,0,0,'11',0,1,'2024-01-14 09:08:49','2024-01-14 09:08:49'),(45,1,1,2,5,0,0,0,0,'7',0,1,'2024-01-14 09:08:54','2024-01-14 09:08:54'),(46,1,1,2,6,0,0,0,0,'9',0,1,'2024-01-14 09:09:00','2024-01-14 09:09:00'),(47,1,1,2,7,0,0,0,0,'5',0,1,'2024-01-14 09:09:06','2024-01-14 09:09:06');
/*!40000 ALTER TABLE `ongoing_team_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_name` varchar(50) DEFAULT NULL,
  `player_team_id` int(11) DEFAULT NULL,
  `player_picture` varchar(255) DEFAULT NULL,
  `player_nickname` varchar(50) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_team_id` (`player_team_id`),
  CONSTRAINT `player_ibfk_1` FOREIGN KEY (`player_team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Team 1 P1',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','KBCAMTB1',1,'2024-01-04 15:38:53','2024-01-04 15:38:53'),(3,'Team 1 P2',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','DSA69',1,'2024-01-04 15:57:51','2024-01-04 15:57:51'),(4,'Team 1 P3',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','RBK666',1,'2024-01-04 15:57:52','2024-01-04 15:57:52'),(5,'Team 1 P4',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','RKO123',1,'2024-01-04 15:57:54','2024-01-04 15:57:54'),(6,'Team 2 P1',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','RiderKtoMah',1,'2024-01-05 12:13:03','2024-01-05 12:13:03'),(7,'Team 2 P2',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','DriverKtoMah',1,'2024-01-05 12:13:29','2024-01-05 12:13:29'),(9,'Team 2 P3',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','ValentinoRo55i',1,'2024-01-05 12:13:51','2024-01-05 12:13:51'),(10,'Team 2 P4',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','DamageRRR',1,'2024-01-05 12:14:37','2024-01-05 12:14:37'),(11,'Player 5',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','BlxP5',1,'2024-01-14 03:35:34','2024-01-14 03:35:34'),(20,'Team 6',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','6',1,'2024-01-14 09:30:37','2024-01-14 09:30:37'),(21,'Team 7',1,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','7',1,'2024-01-14 09:30:48','2024-01-14 09:30:48'),(22,'Player 1',4,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png','p1',1,'2024-01-15 04:43:43','2024-01-15 04:43:43'),(23,'RDZx9k0lva',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(24,'RDZxtu1aje',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(25,'RDZxtwu30i',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(26,'RDZxkaj05',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(27,'RDZxxjshie',2,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(28,'GXxgsrtpi',3,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(29,'GXxo6db3j',3,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(30,'GXxw5q69f',3,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(31,'GXx9gkiyl',3,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(32,'GXxyws02g',3,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(33,'LXxyi23oi',5,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(34,'LXxbh84tc',5,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(35,'LXxsho3e',5,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(36,'LXxffwsjg',5,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(37,'LXxo92nwhg',5,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(38,'CZxfxbj2p',4,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(39,'CZxsvbt6j',4,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(40,'CZxm0grz',4,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(41,'CZxkwyb3v',4,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(42,'CZx4d6w0a',4,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(43,'RTxzpmoie',6,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(44,'RTx80t9yu',6,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(45,'RTxyhiybo',6,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(46,'RTxn2fyd',6,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(47,'RTxh75nw',6,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(48,'OSxy4cypt',7,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(49,'OSxcl4iom',7,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(50,'OSxbekmc9',7,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(51,'OSxhm80sd',7,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(52,'OSxkzosqv',7,'https://cdn.discordapp.com/attachments/1139553071152771072/1183722937698766920/image.png',NULL,1,NULL,NULL),(53,'aa',7,'aa','xyz',1,'2024-01-16 07:47:01','2024-01-16 07:47:01');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rounds`
--

DROP TABLE IF EXISTS `rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rounds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `tournament_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `tournament_id` (`tournament_id`),
  CONSTRAINT `rounds_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rounds`
--

LOCK TABLES `rounds` WRITE;
/*!40000 ALTER TABLE `rounds` DISABLE KEYS */;
INSERT INTO `rounds` VALUES (1,'345b8a3e-6b05d026-b5282d7c',1,'Grand Prix Final Final',1,'2024-01-08 13:44:45','2024-01-08 13:44:45'),(3,'beard-is-on-stake-5f962496',2,'Beard is on stake!',0,'2024-01-08 16:13:28','2024-01-08 16:13:28'),(4,'fire-fire-call-the-puliz-3dfba29a',1,'Fire Fire, Call the Puliz',1,'2024-01-08 18:48:45','2024-01-08 19:48:51'),(8,'the-dawn-before-the-day-ec2ec59e',3,'The Dawn Before The Day!',1,'2024-01-08 19:10:47','2024-01-08 19:45:16'),(10,'day-1-1402c197',5,'Day 1',1,'2024-01-13 10:47:32','2024-01-13 10:47:32'),(11,'day-2-5816f139',5,'DAY 2',1,'2024-01-13 10:47:38','2024-01-13 10:47:38'),(12,'df-4ed6e931',48,'df',1,'2024-01-20 18:29:00','2024-01-20 18:29:00');
/*!40000 ALTER TABLE `rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(50) DEFAULT NULL,
  `team_tag` varchar(50) DEFAULT NULL,
  `team_logo_large` varchar(255) DEFAULT NULL,
  `team_logo_small` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'BULLZ','BZ','https://cdn.discordapp.com/attachments/1139553071152771072/1183728882608771163/image.png','AU',1,'2024-01-04 15:32:17','2024-01-04 15:32:17'),(2,'RiderZ','RDZ','https://cdn.discordapp.com/attachments/1139553071152771072/1183728882608771163/image.png','NP',1,'2024-01-05 12:05:32','2024-01-05 12:05:32'),(3,'General X','GX','https://cdn.discordapp.com/attachments/743763499062132807/752533239326834728/received_580241872862761.jpeg','NP',1,'2024-01-13 10:36:46','2024-01-13 10:36:46'),(4,'Code Zero','CZ','https://media.discordapp.net/attachments/743078808713691297/805428519847854150/IMG-20201014-WA0003.jpg?ex=65ad1b43&is=659aa643&hm=f12e4d5c402cb1c8748eaa563859212e90c72c3d817cb00fafea80e46b42e02b&=&format=webp&width=677&height=677','NP',1,'2024-01-13 10:40:17','2024-01-13 10:40:17'),(5,'Lunatix Xtension','LX','https://cdn.discordapp.com/attachments/802448029378281513/805451678978670632/lunatic_logo_png.png?ex=65ad30d4&is=659abbd4&hm=0dd8e6ded29b6eb9473d936648379c695e3e3e30cd6367625210c63a6fa468b3&','NP',1,'2024-01-13 10:41:16','2024-01-13 10:41:16'),(6,'Radical Terror','RT','https://media.discordapp.net/attachments/742406436964925510/805464355909926912/IMG_0917.jpg?ex=65ad3ca3&is=659ac7a3&hm=0aade7a4ffca63df426488693318950818e028abb95709b0499a4a9546d87122&=&format=webp&width=681&height=677','NP',1,'2024-01-13 10:42:46','2024-01-13 10:42:46'),(7,'Over Seas','OS','https://media.discordapp.net/attachments/805461448842674196/805462102335684618/image0.png?ex=65ad3a89&is=659ac589&hm=a5980951ff9be836a1c1c7b9689b45a79a99732a5669841d390434abe40bbfd2&=&format=webp&quality=lossless&width=600&height=600','NP',1,'2024-01-13 10:43:12','2024-01-13 10:43:12');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist`
--

DROP TABLE IF EXISTS `token_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist`
--

LOCK TABLES `token_blacklist` WRITE;
/*!40000 ALTER TABLE `token_blacklist` DISABLE KEYS */;
INSERT INTO `token_blacklist` VALUES (1,'bc007438-f240-4725-a57b-a4121f5b0fd0','2024-01-22 16:23:23');
/*!40000 ALTER TABLE `token_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournaments`
--

DROP TABLE IF EXISTS `tournaments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournaments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `starts_from` datetime DEFAULT NULL,
  `ends_in` datetime DEFAULT NULL,
  `theme_primary` varchar(255) DEFAULT NULL,
  `theme_secondary` varchar(255) DEFAULT NULL,
  `opacity_scale` float DEFAULT NULL,
  `opacity_color` varchar(100) DEFAULT NULL,
  `text_primary` varchar(255) DEFAULT NULL,
  `text_secondary` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournaments`
--

LOCK TABLES `tournaments` WRITE;
/*!40000 ALTER TABLE `tournaments` DISABLE KEYS */;
INSERT INTO `tournaments` VALUES (1,'905d01dc-6a53981c-a1e953bb','GAND MASTI','2024-01-08 14:51:32','2024-01-09 14:51:32','#fff000','#fff000',0.5,'#000fff','#000fff','#000fff',1,'2024-01-08 14:51:32','2024-01-21 16:38:55'),(2,'this-is-a-test-tournament-8693572e','This is a test tournament','2024-01-08 16:02:04','2024-01-08 16:02:04','#000000','#000000',0.5,'0.5','#000000','#000000',1,'2024-01-08 16:02:04','2024-01-08 16:02:04'),(3,'whack-a-hole-in-the-heaaaad-77a0bc27','Whack A Hole In the Heaaaad!!!','2024-01-08 23:00:00','2024-01-08 23:01:00','#fff000','#fff000',1,'1','#000fff','#000fff',0,'2024-01-08 17:32:51','2024-01-08 18:10:34'),(4,'is-this-active-c85b9f98','Is this active?','2024-01-25 08:00:00','2024-01-26 02:00:00','#000000','#000000',1,'1','#000000','#000000',0,'2024-01-08 18:08:07','2024-01-08 18:08:07'),(5,'pubg-mobile--home-tournament-54bf4ac3','PUBG MOBILE  HOME TOURNAMENT','2024-01-25 08:00:00','2024-01-26 02:00:00','#05fffb','#ffffff',0.4,'#05fffb','#05fffb','#000000',1,'2024-01-13 10:47:23','2024-01-13 10:47:23'),(6,'nne-7c8eb455','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(7,'fhf-4e959c92','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(8,'fhf-ab31133c','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(9,'ty-8ea94e84','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(10,'fhf-8cce510e','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(11,'fhf-04d9d405','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(12,'ty-6a69c61c','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(13,'ty-727858d0','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(14,'nne-83f3c708','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(15,'ty-153174b2','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(16,'fhf-1f127864','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(17,'fhf-d929e24b','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(18,'fhf-89cbe4aa','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(19,'ty-9059d2ca','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(20,'nne-96428a84','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(21,'fhf-f7683c8c','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(22,'fhf-c72d31e2','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(23,'fhf-c96e990a','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:48','2024-01-20 18:28:48'),(24,'nne-72d9169b','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(25,'ty-e0f36c1c','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(26,'fhf-307307e5','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(27,'fhf-bb92f934','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(28,'fhf-91fcde5d','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(29,'ty-ba8ed8b3','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(30,'ty-f1c0fb0a','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(31,'ty-ddb4e953','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(32,'fhf-289a2ec6','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(33,'nne-bda744f9','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(34,'ty-9eca282c','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(35,'ty-e5f99159','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(36,'ty-ce4b65f7','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(37,'ty-6baac0e8','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(38,'fhf-80f5a8a1','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(39,'ty-037e9ff7','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(40,'fhf-146c81d0','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(41,'nne-b7fe7f69','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(42,'fhf-4daca661','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(43,'ty-8e3c7b01','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(44,'nne-bec933a9','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(45,'fhf-35014861','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(46,'nne-2e26f124','nne','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(47,'fhf-511e9574','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(48,'fhf-f89b3d5d','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(49,'ty-30fa9a33','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(50,'ty-629348ee','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(51,'fhf-0fd497c1','fhf','2024-01-25 08:00:00','2024-01-26 02:00:00','#1800cc','#ffffff',0.5,'#1800cc','#1800cc','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(52,'ty-b727f634','ty','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-20 18:28:49','2024-01-20 18:28:49'),(53,'nne-s1-d080bef2','NNE S1','2024-01-25 08:00:00','2024-01-26 02:00:00','#ff0000','#ffffff',0.5,'#ff0000','#ff0000','#000000',1,'2024-01-24 06:36:43','2024-01-24 06:36:43');
/*!40000 ALTER TABLE `tournaments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_activity`
--

DROP TABLE IF EXISTS `user_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `table_changed` varchar(200) DEFAULT NULL,
  `operation_id` int(11) DEFAULT NULL,
  `icon` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `operation_id` (`operation_id`),
  CONSTRAINT `user_activity_ibfk_1` FOREIGN KEY (`operation_id`) REFERENCES `user_operations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_activity`
--

LOCK TABLES `user_activity` WRITE;
/*!40000 ALTER TABLE `user_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operations`
--

DROP TABLE IF EXISTS `user_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operations`
--

LOCK TABLES `user_operations` WRITE;
/*!40000 ALTER TABLE `user_operations` DISABLE KEYS */;
INSERT INTO `user_operations` VALUES (1,'DELETE','danger','Delete a table or table data.'),(2,'UPDATE','warning','Update data of a table.'),(3,'INSERT','success','Insert data into table.');
/*!40000 ALTER TABLE `user_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_session`
--

DROP TABLE IF EXISTS `user_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `refresh_token` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_session_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_session`
--

LOCK TABLES `user_session` WRITE;
/*!40000 ALTER TABLE `user_session` DISABLE KEYS */;
INSERT INTO `user_session` VALUES (21,1,'test','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzY5ODAsImV4cCI6MTcwNjc4MTc4MH0.w-7Z-zf4iOP2WRsZlTtpR5A5sC4YXPxPddcecxb0yRY','2024-01-23 15:51:33','2024-01-25 10:03:00'),(22,1,'prabek','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjc5MTYsImV4cCI6MTcwNjc3MjcxNn0.IxK4KxlKOwWcZHCgfiqweE7dnY7OIfeEwH_wWGeQ7js','2024-01-25 07:31:56','2024-01-25 07:31:56'),(23,1,'fallback_t42y8qz24b','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgwODcsImV4cCI6MTcwNjc3Mjg4N30.FMrckNYPeR-B94tcQJu3lywPIPi1bfyUxggKSYxOfdk','2024-01-25 07:34:47','2024-01-25 07:34:47'),(24,1,'fallback_du4gjgc3g3a','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgxMTEsImV4cCI6MTcwNjc3MjkxMX0.-OjRepTj3yV6XKzvEmBTjhevJeIcz6OjRX4fKZzZPn8','2024-01-25 07:35:11','2024-01-25 07:35:11'),(25,1,'fallback_e650c233nce','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgxMjYsImV4cCI6MTcwNjc3MjkyNn0.6DqMx4elYpddqMMLTSSBWa13E-r1_kgBZof1tD1gdFM','2024-01-25 07:35:27','2024-01-25 07:35:27'),(26,1,'fallback_c6o5kq2f2k','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgyOTksImV4cCI6MTcwNjc3MzA5OX0.oQdCejfkCrpr6U6BIgYXBoHfEZqkPIZnbCG2Hjh_d84','2024-01-25 07:38:19','2024-01-25 07:38:19'),(27,1,'fallback_efcdaburzj','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgzMzAsImV4cCI6MTcwNjc3MzEzMH0.nPggI2plmmVkLaitGx3rBmSDK1xZY1PxS3Vd_kL81-E','2024-01-25 07:38:50','2024-01-25 07:38:50'),(28,1,'fallback_6gtg2dd21pt','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgzMzYsImV4cCI6MTcwNjc3MzEzNn0.evMpT6zYyGauP4WebmP1U9DISX5HRwJksNJvDGiDr0U','2024-01-25 07:38:56','2024-01-25 07:38:56'),(29,1,'fallback_ogiuy8shrgo','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjgzNzYsImV4cCI6MTcwNjc3MzE3Nn0._vtqZ20Nk_XRryD-QfSGC3aOEr5uKAFUFqEi64hDQHw','2024-01-25 07:39:36','2024-01-25 07:39:36'),(30,1,'fallback_0pfg0vhc7df','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjg0NzcsImV4cCI6MTcwNjc3MzI3N30.54Ea2bOlMbq4ZcFUo0OOkenkZGKabSXpLQKKULEDwDk','2024-01-25 07:41:17','2024-01-25 07:41:17'),(31,1,'fallback_rd4n6763gge','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjg1MTUsImV4cCI6MTcwNjc3MzMxNX0._iL6rDeZxB2sDMvDwfKZricDDm_7a7zc2ibA4sIGhOw','2024-01-25 07:41:55','2024-01-25 07:41:55'),(32,1,'fallback_rlex954zvl','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjg2NTMsImV4cCI6MTcwNjc3MzQ1M30.nZ7oqEUVbimgHKDXUnl1S9Ve3KJzfh2H59hbCm4lkog','2024-01-25 07:44:13','2024-01-25 07:44:13'),(33,1,'fallback_dv51g9hphyh','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjg3MjEsImV4cCI6MTcwNjc3MzUyMX0.eyzsvc2yyr0PHJtZHFNRbp9fK9fgD776ol2-zUu1Kts','2024-01-25 07:45:21','2024-01-25 07:45:21'),(34,1,'fallback_obe1ck1lmjc','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjk5NDcsImV4cCI6MTcwNjc3NDc0N30.R7xAY5qhvHF5r_zhmT0KYaAxJDrsNdTPmlgZRN7XnfA','2024-01-25 08:05:47','2024-01-25 08:05:47'),(35,1,'fallback_wfogrq3zpwm','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNjk5NjQsImV4cCI6MTcwNjc3NDc2NH0.wQtD4v2-y7eVidmGCNUStn7KlgeyZ4-gogL-4VV9Tfk','2024-01-25 08:06:04','2024-01-25 08:06:04'),(36,1,'fallback_3q77ddsci9r','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAwNzIsImV4cCI6MTcwNjc3NDg3Mn0.IDyhckNWPSGTL9H0ZuyUE3q0ibhOL9AuBcNWkpdMXK4','2024-01-25 08:07:52','2024-01-25 08:07:52'),(37,1,'fallback_zu3smrvznx','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAwOTQsImV4cCI6MTcwNjc3NDg5NH0.xsM7gAvISUC9KZxxqLAegwkM4ragLKFwdmCwRBKBKe8','2024-01-25 08:08:14','2024-01-25 08:08:14'),(38,1,'fallback_tat2einwvy8','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAwOTcsImV4cCI6MTcwNjc3NDg5N30.AMSwstkwBOPKt6_Yy6hVXcbzvI8-k4wlSzT-Cwded5s','2024-01-25 08:08:17','2024-01-25 08:08:17'),(39,1,'fallback_f8e5m6zbx5w','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMDAsImV4cCI6MTcwNjc3NDkwMH0.WOjZb0Dh4KP_x6SZuXZU1JutGPOtOv7c4kbQgRHUE7k','2024-01-25 08:08:20','2024-01-25 08:08:20'),(40,1,'fallback_x08ot90f9nm','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMDgsImV4cCI6MTcwNjc3NDkwOH0.sJkHprtCVlSZ-6Sgocvbk3uCM33Fk7zl3KyuXpRWwxo','2024-01-25 08:08:28','2024-01-25 08:08:28'),(41,1,'fallback_ak1v9h7h0q9','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMTEsImV4cCI6MTcwNjc3NDkxMX0.2CI5I_HVBpj3lboeiI10T9bOV6c-GO7Mcy1xB5pZTP4','2024-01-25 08:08:31','2024-01-25 08:08:31'),(42,1,'fallback_fimpetyiq4h','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMTUsImV4cCI6MTcwNjc3NDkxNX0.nKAgcpMu5Uo5T2w-8FaDuj-j36YWGObnq9-yhyuEp30','2024-01-25 08:08:36','2024-01-25 08:08:36'),(43,1,'fallback_l67pjuq5ylc','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMTgsImV4cCI6MTcwNjc3NDkxOH0.bq9LvnsXWcEbs4KmBKU6hW1v10-AXJxPnXmugcSbDU0','2024-01-25 08:08:38','2024-01-25 08:08:38'),(44,1,'fallback_rr9fimucehp','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMjEsImV4cCI6MTcwNjc3NDkyMX0.4BDxTDooAVfT08uUnaKyUyYjb2Pp8BlKRhRvZdRddYM','2024-01-25 08:08:41','2024-01-25 08:08:41'),(45,1,'fallback_xp9mj7vxo7','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMjEsImV4cCI6MTcwNjc3NDkyMX0.4BDxTDooAVfT08uUnaKyUyYjb2Pp8BlKRhRvZdRddYM','2024-01-25 08:08:41','2024-01-25 08:08:41'),(46,1,'fallback_7okic8rtp9h','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMjIsImV4cCI6MTcwNjc3NDkyMn0.lq4X-MFCiMOKzWjKnkKT4tfVpKqlz7sJgibN3MRXId8','2024-01-25 08:08:42','2024-01-25 08:08:42'),(47,1,'fallback_g56569cq5ze','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMjIsImV4cCI6MTcwNjc3NDkyMn0.lq4X-MFCiMOKzWjKnkKT4tfVpKqlz7sJgibN3MRXId8','2024-01-25 08:08:42','2024-01-25 08:08:42'),(48,1,'fallback_eg89v76855t','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxMzAsImV4cCI6MTcwNjc3NDkzMH0.k1x3vrzmWdfYhjl3NBwhZ6x6k2RaCDJBgm-lBEUqvG0','2024-01-25 08:08:50','2024-01-25 08:08:50'),(49,1,'fallback_49eameens56','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxNDAsImV4cCI6MTcwNjc3NDk0MH0.NQB7Upq6ZFnkjm9hCa_a5hl7nqaLy22sN3M1eGQ92xQ','2024-01-25 08:09:00','2024-01-25 08:09:00'),(50,1,'fallback_u9lf2933ia','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAxODYsImV4cCI6MTcwNjc3NDk4Nn0.RHmcWQW01PY3GKx0OszidTT372lEdEoxLpL5HhbG5WA','2024-01-25 08:09:46','2024-01-25 08:09:46'),(51,1,'fallback_2mayc0lnxkx','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAyMzcsImV4cCI6MTcwNjc3NTAzN30.UgxIRDMBJItErCM6Pve3LhzYmr7GGE3-eOMARIhQDDs','2024-01-25 08:10:37','2024-01-25 08:10:37'),(52,1,'fallback_vhnxvfnmxdg','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAyNzMsImV4cCI6MTcwNjc3NTA3M30.0zHg9_6nDxCK3hyb8TRx2IucN2ciMAwuvWlQVoZNSGE','2024-01-25 08:11:13','2024-01-25 08:11:13'),(53,1,'fallback_erio4fnlzjf','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzAyOTgsImV4cCI6MTcwNjc3NTA5OH0.4zJOKe1arq_GPtJNIyQkzc89RWR27ODA1OmMQ0UhSkA','2024-01-25 08:11:38','2024-01-25 08:11:38'),(54,1,'fallback_w16qq6w27w8','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzMxMTUsImV4cCI6MTcwNjc3NzkxNX0.uV7_Xmlj7LkQd58ZxeOZVkJ-Ko2zl6aYPuMutws3lJ4','2024-01-25 08:58:35','2024-01-25 08:58:35'),(55,1,'fallback_i7f82gcys5','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzQ3MTQsImV4cCI6MTcwNjc3OTUxNH0.PLDlnl2_nYh0SWqG1tLys9bEx4FhDLoMMSk5iA1qQ74','2024-01-25 09:25:15','2024-01-25 09:25:15'),(56,1,'fallback_slgq25frmah','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzc3NTQsImV4cCI6MTcwNjc4MjU1NH0.OwSJ97PQ4ut3sTZrrVoKp3dEKJjFYE2SgMboqARg0AU','2024-01-25 10:15:54','2024-01-25 10:15:54'),(57,1,'fallback_uu4yypypf6r','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxNzk3NzAsImV4cCI6MTcwNjc4NDU3MH0.MK2byy0oXcCPAyhyObiM17S7x7Gy9HgHxyUNBIHp6ls','2024-01-25 10:49:30','2024-01-25 10:49:30'),(58,1,'fallback_zv2aobxcdpd','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6IkpvaG4iLCJsYXN0X25hbWUiOiJEb2UiLCJlbWFpbCI6ImI3MjYyODQxN0BnbWFpbC5jb20iLCJpYXQiOjE3MDYxOTkwNjgsImV4cCI6MTcwNjgwMzg2OH0.Y1RtFaQHTbGbayfGXiy7NKKAvxwAZ2dwQMTNwOI5MhE','2024-01-25 16:11:09','2024-01-25 16:11:09');
/*!40000 ALTER TABLE `user_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `reset_token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John','Doe','b72628417@gmail.com','$2a$10$cZDZPgtj9/oMXclnGnAq3uhidAbYmLlY2WuT7V0nIt0PmXiKQmIC2','https://example.com/profile.jpg','bc007438-f240-4725-a57b-a4121f5b0fd0',0,1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaXJzdF9uYW1lIjoiSm9obiIsImxhc3RfbmFtZSI6IkRvZSIsImVtYWlsIjoiYjcyNjI4NDE3QGdtYWlsLmNvbSIsImlhdCI6MTcwNjE3ODgzOCwiZXhwIjoxNzA2MTc5MTM4fQ.LChtlME8XgMSM7qKwnTvAoWVg74C5dLTtzJ5jmdXzuM','2024-01-22 16:22:30'),(2,'John','Doe','johndoe@example.com','$2a$10$Vajo2o2QSjAD.xTyR9LPeeQnx9zdhBSLzWKpF1uL3GLTudlqf.92q','https://example.com/profile.jpg','85a0fa4b-2f49-4208-801d-d4beef9261ff',0,0,'','2024-01-25 06:01:01'),(3,'prabek','bajracharya','nglishmen@gmail.com','$2a$10$heRkbFqZtRAeCZLaWF4zWOBQ7g33Is6CXa5EoaPSC6JsKUyPM1caG','https://www.pubgmobile.com/images/event/home/part6.jpg','f4c7d423-fda1-4c4f-96ef-8ed51bf01f54',0,0,'','2024-01-25 06:46:11'),(4,'prabek','bajra','nglishmenn@gmail.com','$2a$10$kWkDR/bo9.IbZ31rGU1Ez.BBqSnH2dOcQvN9j5PUbtlFccn8lQ0LO','https://www.pubgmobile.com/images/event/home/part6.jpg','73dcdf01-0a47-43fd-8439-58f26631ece3',0,0,'','2024-01-25 07:20:15'),(5,'user','user','user@gmail.com','$2a$10$3.kZWZj8PxBD7.awiHBc3e/csJAbbDbSLs.tQPqpBPg7oe4gWH/TG','user','2b3f074a-4fcd-45cd-ac77-d28e3ae7f768',0,0,'','2024-01-25 07:58:58'),(6,'prabek','bajra','nglishmenn@gmaill.com','$2a$10$64DyGT3YJnYU2GYnKRz04.LEzrk7X5i8OK0vPwirS7rG52mseful6','https://www.pubgmobile.com/images/event/home/part6.jpg','69dff76e-2004-49fc-b7c1-f6ff4d99ee91',0,0,'','2024-01-25 08:03:17'),(7,'prabek','user','b7262841@gmail.com','$2a$10$8ZOtNEjTGOosFAf.6ckdduHR1A1nvvjCySXvugMz7ZkRfUEwnjXDq','https://www.pubgmobile.com/images/event/home/part6.jpg','0d8b5773-4439-4172-84fb-7e00740d8925',0,0,'','2024-01-25 08:29:51');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bimashco_obspubg'
--

--
-- Dumping routines for database 'bimashco_obspubg'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-11 21:56:23
