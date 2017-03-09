-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: eshop
-- ------------------------------------------------------
-- Server version	5.7.12-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminuser`
--

DROP TABLE IF EXISTS `adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminuser` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminuser`
--

LOCK TABLES `adminuser` WRITE;
/*!40000 ALTER TABLE `adminuser` DISABLE KEYS */;
INSERT INTO `adminuser` VALUES (1,'admin','admin');
/*!40000 ALTER TABLE `adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Mens Clothes'),(2,'Womens Clothes'),(3,'Shoes'),(4,'Accessories'),(5,'Furniture');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorysecond`
--

DROP TABLE IF EXISTS `categorysecond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorysecond` (
  `csid` int(11) NOT NULL AUTO_INCREMENT,
  `csname` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`csid`),
  KEY `FK936FCAF21DB1FD15` (`cid`),
  CONSTRAINT `FK936FCAF21DB1FD15` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorysecond`
--

LOCK TABLES `categorysecond` WRITE;
/*!40000 ALTER TABLE `categorysecond` DISABLE KEYS */;
INSERT INTO `categorysecond` VALUES (1,'T-shirt',1),(2,'Shirt',1),(3,'Pant',1),(4,'Jacket',1),(5,'Coat',1),(9,'Top',2),(11,'Pant',2),(12,'Skirt',2),(13,'Jacket',2),(14,'Coat',2),(15,'Casual Shoes',3),(16,'Boots',3),(17,'Dress Shoes',3),(20,'Belt',4),(21,'Glasses',4),(22,'Watches',4),(23,'Bags',4),(24,'Chair',5),(25,'Table',5),(26,'Bed',5),(37,'Hat',4);
/*!40000 ALTER TABLE `categorysecond` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `commentid` int(11) NOT NULL AUTO_INCREMENT,
  `commenttime` datetime DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`commentid`),
  KEY `FK_3sstmuluk1l327ya2djnqgwhe` (`pid`),
  KEY `FK_8skei9y57scu5423sr11mikpa` (`uid`),
  CONSTRAINT `FK_3sstmuluk1l327ya2djnqgwhe` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`),
  CONSTRAINT `FK_8skei9y57scu5423sr11mikpa` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'2016-11-21 23:13:35','very good',98,37);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderitem` (
  `itemid` int(11) NOT NULL AUTO_INCREMENT,
  `count` int(11) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `oid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemid`),
  KEY `FK_j20ulwn7395herx5fobexsp9r` (`oid`),
  KEY `FK_fesqehk2fei30hu4isqgmm36f` (`pid`),
  CONSTRAINT `FK_fesqehk2fei30hu4isqgmm36f` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`),
  CONSTRAINT `FK_j20ulwn7395herx5fobexsp9r` FOREIGN KEY (`oid`) REFERENCES `orders` (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (18,1,59,21,98),(19,1,139,22,99),(20,1,139,24,99);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `addr` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ordertime` datetime DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `FK_tk1pibf08nelmar48icf0w8jn` (`uid`),
  CONSTRAINT `FK_tk1pibf08nelmar48icf0w8jn` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (21,'10703 N MacArthur Blvd #205','CHENGGANG XU','2016-11-21 23:13:35','9722733000',4,59,37),(22,'5001 N MacArthur Blvd','Wei Lack Cao','2016-11-22 00:28:40','9722733000',2,139,37),(24,NULL,NULL,'2016-11-27 23:34:11',NULL,1,139,37);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(255) DEFAULT NULL,
  `market_price` double DEFAULT NULL,
  `shop_price` double DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `pdesc` varchar(255) DEFAULT NULL,
  `is_hot` int(11) DEFAULT NULL,
  `pdate` datetime DEFAULT NULL,
  `csid` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `FKED8DCCEFB9B74E02` (`csid`),
  CONSTRAINT `FKED8DCCEFB9B74E02` FOREIGN KEY (`csid`) REFERENCES `categorysecond` (`csid`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (98,'Packable Hooded Down Jacket',175,59,'image/product/cs70009.png','This packable, down jacket from Weatherproof will help you handle any bad weather Mother Nature brings upon us!',1,'2016-11-22 22:12:16',5),(99,'Calvin Klein Faux-Fur-Trim Chevron Water-Resistant Puffer Coat',275,139,'image/product/cs20007.jpg','Stay warm and comfy no matter how arctic it is out of doors with this cozy puffer coat from Calvin Klein.',1,'2016-11-22 22:12:40',14),(100,'MICHAEL Michael Kors Down Jacket',225,109,'image/product/cs70002.png','This heavy-duty down jacket from Michael Michael Kors features an attached hood and wind resistant material to handle the toughest, coldest conditions in style.',1,'2016-11-22 22:15:55',5),(101,'Tommy Hilfiger Nylon Packable Jacket',195,99,'image/product/tommy.jpg','Style and profile in this nylon packable jacket from Tommy Hilfiger, featuring a packable design for easy transport on those frigid days.',1,'2016-11-22 22:40:27',5),(102,'COWBOY HAT FINAL CLIP ART',39,29,'image/product/cowboyhat.png','COWBOY HAT FINAL CLIP ARTCOWBOY HAT FINAL CLIP ARTCOWBOY HAT FINAL CLIP ARTCOWBOY HAT FINAL CLIP ART',1,'2016-11-23 09:01:15',37),(103,'Ralph Sunglasses RA4104',89,49,'image/product/22.png','Trendy and fashionable looks in vibrant colors, Ralph captures the spirit of Ralph Lauren with an attitude. Designed for young women looking for great design at an accessible price',1,'2016-11-23 09:10:11',21),(105,'Sean John Men\'s Felt Wide Brim Fedora',50,24,'image/product/hat2.jpg','Make a stylish statement when you finish your ensemble with the classic look of this fedora from Sean John, crafted with wool felt and a wide brim.',1,'2016-11-26 02:56:24',37),(106,'Christmas Hat',59,39,'image/product/hat3.png','Fun starts at the top with this festive Santa hat from American Rag, featuring an attached beard and a classic pompom accent.',1,'2016-11-26 03:03:10',37),(107,'Baseball Cap',29,16,'image/product/hat4.png','2015 Holiday Gift Ideas and Guide \r\nBaseball Cap',1,'2016-11-26 03:11:07',37),(108,'glossy round table',599,1299,'image/product/table1.jpg','A table collection ideal both for the home and office environment.',0,'2016-11-29 23:17:55',25),(109,' bubble club side table',199,399,'image/product/table2.png','Bubble Club, made of mass-colored polyethylene is the first interpreter of a new concept of furnishing accessory',0,'2016-11-29 23:19:04',25);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'root','root','root','root@qq.com','15566778899','Irving Texas',1,'34324232321'),(2,'zwb','zwb','zwb','zwb@live.com','13344556677','Commerce Texas',1,'34324232322'),(37,'kevin','123','Kevin Xu','lacry1007@gmail.com','','',1,'7fa6156c7fab452a9f66f295a67c533ba3549184465a42e29fd64a7b1b24299e');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-01 13:10:52
