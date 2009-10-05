-- MySQL dump 10.11
--
-- Host: localhost    Database: drupal6
-- ------------------------------------------------------
-- Server version	5.0.51a-24

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
-- Table structure for table `booklib`
--

DROP TABLE IF EXISTS `booklib`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `booklib` (
  `Title` varchar(99) character set cp1251 NOT NULL default '',
  `Filename` varchar(12) character set latin1 collate latin1_general_ci NOT NULL default '',
  `Date` date NOT NULL default '0000-00-00',
  `Path` varchar(99) character set latin1 collate latin1_general_ci NOT NULL default '',
  `Size` int(11) NOT NULL default '0',
  `Disc` int(11) NOT NULL default '0',
  `Seq` varchar(99) character set cp1251 NOT NULL default '',
  `G1` varchar(99) character set cp1251 NOT NULL default '',
  `G2` varchar(99) character set cp1251 NOT NULL default '',
  `G3` varchar(99) character set cp1251 NOT NULL default '',
  `A1N1` varchar(99) character set cp1251 NOT NULL default '',
  `A1N2` varchar(99) character set cp1251 NOT NULL default '',
  `SeqId` int(11) NOT NULL default '0',
  `SeqN` int(11) NOT NULL default '0',
  `A2N1` varchar(99) character set cp1251 NOT NULL default '',
  `A2N2` varchar(99) character set cp1251 NOT NULL default '',
  `Notes` varchar(254) character set cp1251 NOT NULL default '',
  `ID` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`ID`),
  KEY `Title` (`Title`),
  KEY `Filename` (`Filename`),
  KEY `Date` (`Date`),
  KEY `Path` (`Path`),
  KEY `Size` (`Size`),
  KEY `Seq` (`Seq`),
  KEY `G1` (`G1`),
  KEY `G2` (`G2`),
  KEY `G3` (`G3`),
  KEY `A1N1` (`A1N1`),
  KEY `A1N2` (`A1N2`),
  KEY `A2N1` (`A2N1`),
  KEY `A2N2` (`A2N2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libactions`
--

DROP TABLE IF EXISTS `libactions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libactions` (
  `ActionID` int(11) NOT NULL auto_increment,
  `UserName` varchar(60) character set utf8 collate utf8_bin NOT NULL default '',
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `ActionSQL` text collate utf8_unicode_ci NOT NULL,
  `ActionDesc` text collate utf8_unicode_ci NOT NULL,
  `ActionUndo` text collate utf8_unicode_ci NOT NULL,
  `BookId` int(11) NOT NULL,
  PRIMARY KEY  (`ActionID`),
  KEY `UserName` (`UserName`,`Time`),
  KEY `Time` (`Time`),
  KEY `BookId` (`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libanode`
--

DROP TABLE IF EXISTS `libanode`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libanode` (
  `nid` int(10) unsigned NOT NULL,
  `AvtorId` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`nid`,`AvtorId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libavtor`
--

DROP TABLE IF EXISTS `libavtor`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libavtor` (
  `BookId` int(10) unsigned NOT NULL default '0',
  `AvtorId` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`BookId`,`AvtorId`),
  KEY `iav` (`AvtorId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libavtoraliase`
--

DROP TABLE IF EXISTS `libavtoraliase`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libavtoraliase` (
  `AliaseId` int(11) NOT NULL auto_increment,
  `BadId` int(11) NOT NULL default '0',
  `GoodId` int(11) NOT NULL default '0',
  PRIMARY KEY  (`AliaseId`),
  KEY `u` (`BadId`,`GoodId`),
  KEY `BadId` (`BadId`),
  KEY `GoodId` (`GoodId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='òàáëèöà çàìåíû àâòîðîâ';
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libavtorname`
--

DROP TABLE IF EXISTS `libavtorname`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libavtorname` (
  `AvtorId` int(10) unsigned NOT NULL auto_increment,
  `FirstName` varchar(99) character set utf8 NOT NULL default '',
  `MiddleName` varchar(99) character set utf8 NOT NULL default '',
  `LastName` varchar(99) character set utf8 NOT NULL default '',
  `NickName` varchar(33) character set utf8 NOT NULL default '',
  `NoDonate` char(1) collate utf8_unicode_ci NOT NULL default '' COMMENT 'ï...î - áå...ì, 1 - íåò',
  `uid` int(11) NOT NULL default '0',
  `WebPay` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `Email` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `Homepage` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `Blocked` char(1) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  USING BTREE (`AvtorId`),
  KEY `FirstName` (`FirstName`(20)),
  KEY `LastName` (`LastName`(20)),
  KEY `NoDonate` (`NoDonate`),
  KEY `Email` (`Email`),
  KEY `Homepage` (`Homepage`),
  FULLTEXT KEY `FirstName_2` (`FirstName`,`MiddleName`,`LastName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libblocked`
--

DROP TABLE IF EXISTS `libblocked`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libblocked` (
  `BookId` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `block` char(1) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libbnode`
--

DROP TABLE IF EXISTS `libbnode`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libbnode` (
  `nid` int(10) unsigned NOT NULL,
  `BookId` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`nid`,`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libbook`
--

DROP TABLE IF EXISTS `libbook`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libbook` (
  `BookId` int(10) unsigned NOT NULL auto_increment,
  `FileSize` int(10) unsigned NOT NULL default '0',
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `Title` varchar(254) collate utf8_unicode_ci NOT NULL default '',
  `Title1` varchar(254) character set utf8 NOT NULL,
  `Lang` char(2) character set utf8 NOT NULL default 'ru',
  `FileType` char(4) character set utf8 NOT NULL,
  `Year` smallint(6) NOT NULL default '0',
  `Deleted` char(1) collate utf8_unicode_ci NOT NULL default '',
  `Ver` varchar(8) character set utf8 NOT NULL default '',
  `FileAuthor` varchar(64) character set utf8 NOT NULL,
  `N` int(10) unsigned NOT NULL default '0',
  `keywords` varchar(255) character set utf8 NOT NULL,
  `Blocked` char(1) collate utf8_unicode_ci NOT NULL,
  `md5` char(32) character set utf8 NOT NULL,
  `Broken` char(1) character set armscii8 collate armscii8_bin NOT NULL COMMENT 'mark bad fb2',
  PRIMARY KEY  (`BookId`),
  UNIQUE KEY `md5` (`md5`),
  KEY `Title` (`Title`),
  KEY `Year` (`Year`),
  KEY `Deleted` (`Deleted`),
  KEY `FileType` (`FileType`),
  KEY `Lang` (`Lang`),
  KEY `FileSize` (`FileSize`),
  KEY `FileAuthor` (`FileAuthor`),
  KEY `N` (`N`),
  KEY `Title1` (`Title1`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libbookwatch`
--

DROP TABLE IF EXISTS `libbookwatch`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libbookwatch` (
  `UserId` int(11) NOT NULL,
  `BookId` int(11) NOT NULL,
  PRIMARY KEY  (`UserId`,`BookId`),
  KEY `UserId` (`UserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libcache`
--

DROP TABLE IF EXISTS `libcache`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libcache` (
  `BookId` int(11) NOT NULL default '0',
  `TOC` text collate utf8_unicode_ci NOT NULL,
  `Cover` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libcache1`
--

DROP TABLE IF EXISTS `libcache1`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libcache1` (
  `BookId` int(11) NOT NULL default '0',
  `Advise` varchar(255) NOT NULL default '',
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libcacheid`
--

DROP TABLE IF EXISTS `libcacheid`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libcacheid` (
  `BookId` int(11) NOT NULL,
  `Id` varchar(99) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`BookId`),
  KEY `Id` (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libdonations`
--

DROP TABLE IF EXISTS `libdonations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libdonations` (
  `DonateId` int(11) NOT NULL auto_increment,
  `uid` int(11) NOT NULL default '0',
  `Sum` int(11) NOT NULL default '0',
  `Type` char(1) collate utf8_unicode_ci NOT NULL default '',
  `AvtorId` int(11) NOT NULL default '0',
  `PayType` char(10) collate utf8_unicode_ci NOT NULL default '' COMMENT 'à?àËàÀá?á?àÆàÍàÀá? á?àÈá?á?àÅàÌàÀ',
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`DonateId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libfilename`
--

DROP TABLE IF EXISTS `libfilename`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libfilename` (
  `BookId` int(11) NOT NULL,
  `FileName` varchar(255) character set utf8 NOT NULL,
  PRIMARY KEY  (`BookId`),
  UNIQUE KEY `FileName` (`FileName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libgenre`
--

DROP TABLE IF EXISTS `libgenre`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libgenre` (
  `Id` int(10) unsigned NOT NULL auto_increment,
  `BookId` int(10) unsigned NOT NULL default '0',
  `GenreId` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `u` (`BookId`,`GenreId`),
  KEY `igenre` (`GenreId`),
  KEY `ibook` (`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libgenrelist`
--

DROP TABLE IF EXISTS `libgenrelist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libgenrelist` (
  `GenreId` int(10) unsigned NOT NULL auto_increment,
  `GenreCode` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  `GenreDesc` varchar(99) collate utf8_unicode_ci NOT NULL default '',
  `GenreMeta` varchar(45) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  USING BTREE (`GenreId`,`GenreCode`),
  KEY `meta` (`GenreMeta`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `libgenrelist`
--

LOCK TABLES `libgenrelist` WRITE;
/*!40000 ALTER TABLE `libgenrelist` DISABLE KEYS */;
INSERT INTO `libgenrelist` VALUES (1,'sf_history','Альтернативная история','Фантастика'),(2,'sf_action','Боевая фантастика','Фантастика'),(3,'sf_epic','Эпическая фантастика','Фантастика'),(4,'sf_heroic','Героическая фантастика','Фантастика'),(5,'sf_detective','Детективная фантастика','Фантастика'),(6,'sf_cyberpunk','Киберпанк','Фантастика'),(7,'sf_space','Космическая фантастика','Фантастика'),(8,'sf_social','Социально-психологическая фантастика','Фантастика'),(9,'sf_horror','Ужасы и Мистика','Фантастика'),(10,'sf_humor','Юмористическая фантастика','Фантастика'),(11,'sf_fantasy','Фэнтези','Фантастика'),(12,'sf','Научная Фантастика','Фантастика'),(13,'det_classic','Классический детектив','Детективы и Триллеры'),(14,'det_police','Полицейский детектив','Детективы и Триллеры'),(15,'det_action','Боевик','Детективы и Триллеры'),(16,'det_irony','Иронический детектив','Детективы и Триллеры'),(17,'det_history','Исторический детектив','Детективы и Триллеры'),(18,'det_espionage','Шпионский детектив','Детективы и Триллеры'),(19,'det_crime','Криминальный детектив','Детективы и Триллеры'),(20,'det_political','Политический детектив','Детективы и Триллеры'),(21,'det_maniac','Маньяки','Детективы и Триллеры'),(22,'det_hard','Крутой детектив','Детективы и Триллеры'),(23,'thriller','Триллер','Детективы и Триллеры'),(24,'detective','Детектив','Детективы и Триллеры'),(129,'comp_dsp','Цифровая обработка сигналов','Компьютеры и Интернет'),(25,'prose','Проза','Проза'),(26,'prose_classic','Классическая проза','Проза'),(27,'prose_history','Историческая проза','Проза'),(28,'prose_contemporary','Современная проза','Проза'),(29,'prose_counter','Контркультура','Проза'),(30,'prose_rus_classic','Русская классическая проза','Проза'),(31,'prose_su_classics','Советская классическая проза','Проза'),(32,'love_contemporary','Современные любовные романы','Любовные романы'),(33,'love_history','Исторические любовные романы','Любовные романы'),(34,'love_detective','Остросюжетные любовные романы','Любовные романы'),(35,'love_short','Короткие любовные романы','Любовные романы'),(36,'love_erotica','Эротика','Любовные романы'),(37,'love','О любви','Любовные романы'),(38,'adv_western','Вестерн','Приключения'),(39,'adv_history','Исторические приключения','Приключения'),(40,'adv_indian','Приключения про индейцев','Приключения'),(41,'adv_maritime','Морские приключения','Приключения'),(42,'adv_geo','Путешествия и география','Приключения'),(43,'adv_animal','Природа и животные','Приключения'),(44,'adventure','Приключения','Приключения'),(45,'child_tale','Сказка','Детское'),(46,'child_verse','Детские стихи','Детское'),(47,'child_prose','Детская проза','Детское'),(128,'religion_budda','Буддизм','Религия и духовность'),(48,'child_sf','Детская фантастика','Детское'),(49,'child_det','Детские остросюжетные','Детское'),(50,'child_adv','Детские приключения','Детское'),(51,'child_education','Детская образовательная литература','Детское'),(52,'children','Детская литература','Детское'),(53,'poetry','Поэзия','Поэзия, Драматургия'),(54,'dramaturgy','Драматургия','Поэзия, Драматургия'),(55,'antique_ant','Античная литература','Старинное'),(56,'antique_european','Европейская старинная литература','Старинное'),(57,'antique_russian','Древнерусская литература','Старинное'),(58,'antique_east','Древневосточная литература','Старинное'),(59,'antique_myths','Мифы. Легенды. Эпос','Старинное'),(60,'antique','Старинная литература','Старинное'),(61,'sci_history','История','Наука, Образование'),(62,'sci_psychology','Психология','Наука, Образование'),(63,'sci_culture','Культурология','Наука, Образование'),(64,'sci_religion','Религиоведение','Наука, Образование'),(65,'sci_philosophy','Философия','Наука, Образование'),(66,'sci_politics','Политика','Наука, Образование'),(67,'sci_business','Деловая литература','Наука, Образование'),(68,'sci_juris','Юриспруденция','Наука, Образование'),(69,'sci_linguistic','Языкознание','Наука, Образование'),(70,'sci_medicine','Медицина','Наука, Образование'),(71,'sci_phys','Физика','Наука, Образование'),(72,'sci_math','Математика','Наука, Образование'),(73,'sci_chem','Химия','Наука, Образование'),(74,'sci_biology','Биология','Наука, Образование'),(75,'sci_tech','Технические науки','Наука, Образование'),(76,'science','Научная литература','Наука, Образование'),(77,'comp_www','Интернет','Компьютеры и Интернет'),(78,'comp_programming','Программирование','Компьютеры и Интернет'),(79,'comp_hard','Компьютерное \'железо\' (аппаратное обеспечение)','Компьютеры и Интернет'),(80,'comp_soft','Программы','Компьютеры и Интернет'),(81,'comp_db','Базы данных','Компьютеры и Интернет'),(82,'comp_osnet','ОС и Сети','Компьютеры и Интернет'),(83,'computers','Околокомпьютерная литература','Компьютеры и Интернет'),(127,'notes','Партитуры','Прочее'),(84,'ref_encyc','Энциклопедии','Справочная литература'),(85,'ref_dict','Словари','Справочная литература'),(126,'sci_cosmos','Астрономия и Космос','Наука, Образование'),(86,'ref_ref','Справочники','Справочная литература'),(87,'ref_guide','Руководства','Справочная литература'),(125,'sci_geo','Геология и география','Наука, Образование'),(88,'reference','Справочная литература','Справочная литература'),(124,'sf_fantasy_city','Городское фэнтези','Фантастика'),(89,'nonf_biography','Биографии и Мемуары','Документальная литература'),(90,'nonf_publicism','Публицистика','Документальная литература'),(123,'sci_biophys','Биофизика','Наука, Образование'),(91,'nonf_criticism','Критика','Документальная литература'),(92,'design','Искусство и Дизайн','Документальная литература'),(122,'sci_state','Государство и право','Наука, Образование'),(93,'nonfiction','Документальная литература','Документальная литература'),(94,'religion_rel','Религия','Религия и духовность'),(121,'sci_economy','Экономика','Наука, Образование'),(95,'religion_esoterics','Эзотерика','Религия и духовность'),(96,'religion_self','Самосовершенствование','Религия и духовность'),(120,'sci_build','Строительство и сопромат','Техника'),(97,'religion','Религиозная литература','Религия и духовность'),(119,'sci_radio','Радиоэлектроника','Техника'),(98,'humor_anecdote','Анекдоты','Юмор'),(99,'humor_prose','Юмористическая проза','Юмор'),(100,'humor_verse','Юмористические стихи','Юмор'),(118,'sci_metal','Металлургия','Техника'),(101,'humor','Юмор','Юмор'),(102,'home_cooking','Кулинария','Домоводство (Дом и семья)'),(103,'home_pets','Домашние животные','Домоводство (Дом и семья)'),(117,'sci_transport','Транспорт и авиация','Техника'),(104,'home_crafts','Хобби и ремесла','Домоводство (Дом и семья)'),(105,'home_entertain','Развлечения','Домоводство (Дом и семья)'),(106,'home_health','Здоровье','Домоводство (Дом и семья)'),(116,'sci_orgchem','Органическая химия','Наука, Образование'),(107,'home_garden','Сад и огород','Домоводство (Дом и семья)'),(108,'home_diy','Сделай сам','Домоводство (Дом и семья)'),(109,'home_sport','Спорт','Домоводство (Дом и семья)'),(115,'sci_anachem','Аналитическая химия','Наука, Образование'),(110,'home_sex','Эротика, Секс','Домоводство (Дом и семья)'),(111,'home','Домоводство','Домоводство (Дом и семья)'),(114,'sci_physchem','Физическая химия','Наука, Образование'),(112,'other','Неотсортированное','Прочее'),(113,'sci_biochem','Биохимия','Наука, Образование'),(130,'prose_military','О войне','Проза'),(131,'sf_postapocalyptic','Постапокалипсис','Фантастика'),(132,'banking','Банковское дело','Деловая литература'),(133,'accounting','Бухучет, налогообложение, аудит','Деловая литература'),(134,'global_economy','Внешнеэкономическая деятельность','Деловая литература'),(135,'paper_work','Делопроизводство','Деловая литература'),(136,'org_behavior','Корпоративная культура','Деловая литература'),(137,'personal_finance','Личные финансы','Деловая литература'),(138,'small_business','Малый бизнес','Деловая литература'),(139,'marketing','Маркетинг, PR, реклама','Деловая литература'),(140,'real_estate','Недвижимость','Деловая литература'),(141,'popular_business','О бизнесе популярно','Деловая литература'),(142,'industries','Отраслевые издания','Деловая литература'),(143,'job_hunting','Поиск работы, карьера','Деловая литература'),(144,'economics_ref','Справочники','Деловая литература'),(145,'management','Управление, подбор персонала','Деловая литература'),(146,'stock','Ценные бумаги, инвестиции','Деловая литература'),(147,'economics','Экономика','Деловая литература'),(148,'love_sf','Любовно-фантастические романы','Любовные романы');
/*!40000 ALTER TABLE `libgenrelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libjoinedbooks`
--

DROP TABLE IF EXISTS `libjoinedbooks`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libjoinedbooks` (
  `Id` int(11) NOT NULL auto_increment,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `BadId` int(11) NOT NULL default '0',
  `GoodId` int(11) NOT NULL default '0',
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `BadId` (`BadId`),
  KEY `Time` (`Time`),
  KEY `GoodId` (`GoodId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `liblog`
--

DROP TABLE IF EXISTS `liblog`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `liblog` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `UserId` char(15) character set ascii collate ascii_bin NOT NULL default '',
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `BookId` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`),
  KEY `User` (`UserId`),
  KEY `Time` (`Time`),
  KEY `url` (`BookId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 DELAY_KEY_WRITE=1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libmass`
--

DROP TABLE IF EXISTS `libmass`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libmass` (
  `ID` int(10) unsigned NOT NULL auto_increment,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Books` varchar(1000) collate utf8_unicode_ci NOT NULL,
  `N` int(11) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `Time` (`Time`),
  KEY `N` (`N`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libpolka`
--

DROP TABLE IF EXISTS `libpolka`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libpolka` (
  `Id` int(10) unsigned NOT NULL auto_increment,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `BookId` int(11) NOT NULL default '0',
  `AvtorId` int(11) NOT NULL default '0',
  `UserId` int(11) NOT NULL default '0',
  `Text` text character set utf8 NOT NULL,
  `Flag` char(1) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `ub` (`BookId`,`UserId`),
  KEY `BookId` (`BookId`),
  KEY `AvtorId` (`AvtorId`),
  KEY `User` (`UserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libpolkarate`
--

DROP TABLE IF EXISTS `libpolkarate`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libpolkarate` (
  `Id` int(11) NOT NULL COMMENT 'libpolka.id',
  `uid` int(11) NOT NULL,
  `rate` tinyint(4) NOT NULL,
  PRIMARY KEY  (`Id`,`uid`),
  KEY `rate` (`rate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libquality`
--

DROP TABLE IF EXISTS `libquality`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libquality` (
  `BookId` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `q` char(1) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ub` (`BookId`,`uid`),
  KEY `BookId` (`BookId`),
  KEY `uid` (`uid`),
  KEY `q` (`q`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `librate`
--

DROP TABLE IF EXISTS `librate`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `librate` (
  `ID` int(11) NOT NULL auto_increment,
  `BookId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Rate` char(1) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `BookId` (`BookId`,`UserId`),
  KEY `UserId` (`UserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libreaded`
--

DROP TABLE IF EXISTS `libreaded`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libreaded` (
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `BookId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY  (`BookId`,`UserId`),
  KEY `Time` (`Time`),
  KEY `UserId` (`UserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `librusec`
--

DROP TABLE IF EXISTS `librusec`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `librusec` (
  `cid` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `data` varchar(21000) collate utf8_unicode_ci default NULL,
  `expire` int(11) NOT NULL default '0',
  `created` int(11) NOT NULL default '0',
  `headers` varchar(255) collate utf8_unicode_ci default NULL,
  `serialized` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`cid`),
  KEY `expire` (`expire`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libseq`
--

DROP TABLE IF EXISTS `libseq`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libseq` (
  `BookId` int(11) NOT NULL,
  `SeqId` int(11) NOT NULL,
  `SeqNumb` tinyint(4) NOT NULL,
  `Level` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`BookId`,`SeqId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libseqname`
--

DROP TABLE IF EXISTS `libseqname`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libseqname` (
  `SeqId` int(10) unsigned NOT NULL auto_increment,
  `SeqName` varchar(254) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`SeqId`),
  UNIQUE KEY `SeqName` (`SeqName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libsrclang`
--

DROP TABLE IF EXISTS `libsrclang`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libsrclang` (
  `BookId` int(11) NOT NULL,
  `SrcLang` char(2) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`BookId`),
  KEY `SrcLang` (`SrcLang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libstat`
--

DROP TABLE IF EXISTS `libstat`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libstat` (
  `BookId` int(11) NOT NULL,
  `Mes` char(4) collate utf8_unicode_ci NOT NULL,
  `N` int(11) NOT NULL,
  UNIQUE KEY `BookId` (`BookId`,`Mes`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libtopadvert`
--

DROP TABLE IF EXISTS `libtopadvert`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libtopadvert` (
  `BookId` int(11) NOT NULL,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`BookId`),
  KEY `Time` (`Time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libtranslator`
--

DROP TABLE IF EXISTS `libtranslator`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libtranslator` (
  `BookId` int(10) unsigned NOT NULL default '0',
  `TranslatorId` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`BookId`,`TranslatorId`),
  KEY `iav` (`TranslatorId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libuserblackgenre`
--

DROP TABLE IF EXISTS `libuserblackgenre`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libuserblackgenre` (
  `UserId` int(11) NOT NULL,
  `GenreId` int(11) NOT NULL,
  PRIMARY KEY  (`UserId`,`GenreId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `libuseropt`
--

DROP TABLE IF EXISTS `libuseropt`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `libuseropt` (
  `User` int(11) NOT NULL default '0',
  `Opt` char(1) collate utf8_unicode_ci NOT NULL,
  `Value` char(4) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`User`,`Opt`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-09-07 12:21:51
