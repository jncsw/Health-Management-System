/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : dbdesign

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-04-29 19:21:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sno` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cook
-- ----------------------------
DROP TABLE IF EXISTS `cook`;
CREATE TABLE `cook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `iid` int(11) DEFAULT NULL,
  `cnt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `iid` (`iid`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `course` (`id`),
  CONSTRAINT `iid` FOREIGN KEY (`iid`) REFERENCES `ingredients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `energy` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `classification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ingredients
-- ----------------------------
DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(255) DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sno` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `olid` varchar(255) DEFAULT NULL,
  `arrived` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sno` (`sno`),
  CONSTRAINT `sno` FOREIGN KEY (`sno`) REFERENCES `userinfo` (`sno`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orderlist
-- ----------------------------
DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE `orderlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oid` (`oid`),
  KEY `cids` (`cid`),
  CONSTRAINT `cids` FOREIGN KEY (`cid`) REFERENCES `course` (`id`),
  CONSTRAINT `oid` FOREIGN KEY (`oid`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for schoolinfo
-- ----------------------------
DROP TABLE IF EXISTS `schoolinfo`;
CREATE TABLE `schoolinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sno` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `idnum` varchar(255) DEFAULT NULL,
  `building` varchar(255) DEFAULT NULL,
  `dorm` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sno` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for stuinfo
-- ----------------------------
DROP TABLE IF EXISTS `stuinfo`;
CREATE TABLE `stuinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sno` varchar(255) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `stature` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `BloodPressure` varchar(255) DEFAULT NULL,
  `HeartRate` varchar(255) DEFAULT NULL,
  `Visionl` varchar(255) DEFAULT NULL,
  `Visionr` varchar(255) DEFAULT NULL,
  `Otherdata` varchar(255) DEFAULT NULL,
  `Sugg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`sno`),
  KEY `stu` (`sno`),
  CONSTRAINT `stu` FOREIGN KEY (`sno`) REFERENCES `userinfo` (`sno`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sno` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `stature` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `BMI` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `QQ` varchar(255) DEFAULT NULL,
  `TEL` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `BloodPressure` varchar(255) DEFAULT NULL,
  `HeartRate` varchar(255) DEFAULT NULL,
  `Visionl` varchar(255) DEFAULT NULL,
  `Visionr` varchar(255) DEFAULT NULL,
  `Otherdata` varchar(255) DEFAULT NULL,
  `Sugg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `School` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TRIGGER IF EXISTS `CourseTri`;
DELIMITER ;;
CREATE TRIGGER `CourseTri` BEFORE INSERT ON `course` FOR EACH ROW BEGIN
	IF NEW.energy <=100 THEN
					SET NEW.level = 1;
	END IF;
	IF NEW.energy >100 AND NEW.energy<=300 THEN
					SET NEW.level=2;
	END IF;
	IF NEW.energy >=300 THEN SET NEW.level=3;
	END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `userinfotri2`;
DELIMITER ;;
CREATE TRIGGER `userinfotri2` BEFORE INSERT ON `userinfo` FOR EACH ROW BEGIN
	SET NEW.BMI = NEW.weight/((NEW.stature)*(NEW.stature));
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `admintri`;
DELIMITER ;;
CREATE TRIGGER `admintri` AFTER INSERT ON `userinfo` FOR EACH ROW BEGIN
     insert into admin(sno,name,rank) values(new.sno,new.name,1);
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `userinfotri`;
DELIMITER ;;
CREATE TRIGGER `userinfotri` BEFORE UPDATE ON `userinfo` FOR EACH ROW BEGIN
	SET NEW.BMI = NEW.weight/((NEW.stature)*(NEW.stature));
END
;;
DELIMITER ;
