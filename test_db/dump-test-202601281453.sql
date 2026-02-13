-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `drivers_table`
--

DROP TABLE IF EXISTS `drivers_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drivers_table` (
  `driver_id` int NOT NULL,
  `driver_name` varchar(100) NOT NULL,
  `contact` varchar(100) NOT NULL,
  `review_score` float DEFAULT NULL,
  PRIMARY KEY (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table about drivers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drivers_table`
--

LOCK TABLES `drivers_table` WRITE;
/*!40000 ALTER TABLE `drivers_table` DISABLE KEYS */;
INSERT INTO `drivers_table` VALUES (101,'Parashar wale bhaiya','+91 99999 99999',10);
/*!40000 ALTER TABLE `drivers_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ledger_table`
--

DROP TABLE IF EXISTS `ledger_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ledger_table` (
  `booking_id` int NOT NULL,
  `user_id` int NOT NULL,
  `ride_id` int NOT NULL,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `ledger_table_unique` (`user_id`),
  UNIQUE KEY `ledger_table_unique_1` (`ride_id`),
  KEY `ledger_table_user_id_IDX` (`user_id`) USING BTREE,
  CONSTRAINT `ledger_table_rides_table_FK` FOREIGN KEY (`ride_id`) REFERENCES `rides_table` (`ride_id`),
  CONSTRAINT `ledger_table_users_table_FK` FOREIGN KEY (`user_id`) REFERENCES `users_table` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ledger_table`
--

LOCK TABLES `ledger_table` WRITE;
/*!40000 ALTER TABLE `ledger_table` DISABLE KEYS */;
INSERT INTO `ledger_table` VALUES (1,1,1,'C');
/*!40000 ALTER TABLE `ledger_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rides_table`
--

DROP TABLE IF EXISTS `rides_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rides_table` (
  `ride_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `date_and_time` datetime DEFAULT NULL,
  `status` char(1) NOT NULL,
  `total_space` int NOT NULL,
  PRIMARY KEY (`ride_id`),
  UNIQUE KEY `rides_table_unique` (`driver_id`),
  KEY `rides_table_source_IDX` (`source`) USING BTREE,
  KEY `rides_table_destination_IDX` (`destination`) USING BTREE,
  CONSTRAINT `rides_table_drivers_table_FK` FOREIGN KEY (`driver_id`) REFERENCES `drivers_table` (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rides_table`
--

LOCK TABLES `rides_table` WRITE;
/*!40000 ALTER TABLE `rides_table` DISABLE KEYS */;
INSERT INTO `rides_table` VALUES (1,101,'Mandi','Manali','0001-02-26 00:00:00','C',4);
/*!40000 ALTER TABLE `rides_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_table`
--

DROP TABLE IF EXISTS `users_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_table` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rollno` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_table`
--

LOCK TABLES `users_table` WRITE;
/*!40000 ALTER TABLE `users_table` DISABLE KEYS */;
INSERT INTO `users_table` VALUES (1,'Saatvik','b23411@students.iitmandi.ac.in','B23411','M'),(2,'Nishita','b23403@students.iitmandi.ac.in','B23403','F');
/*!40000 ALTER TABLE `users_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-28 14:53:05
