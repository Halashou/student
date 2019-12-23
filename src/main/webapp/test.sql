/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50559
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50559
File Encoding         : 65001

Date: 2019-11-04 18:25:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_class
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(50) DEFAULT NULL,
  `monitor` varchar(20) DEFAULT NULL,
  `tid` varchar(8) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `fk_gid` (`gid`),
  KEY `fk_tid` (`tid`),
  CONSTRAINT `fk_gid` FOREIGN KEY (`gid`) REFERENCES `t_grade` (`id`),
  CONSTRAINT `fk_tid` FOREIGN KEY (`tid`) REFERENCES `t_teacher` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_class
-- ----------------------------
INSERT INTO `t_class` VALUES ('1', '软工一班', '李明', '10250001', '1', null);

-- ----------------------------
-- Table structure for t_grade
-- ----------------------------
DROP TABLE IF EXISTS `t_grade`;
CREATE TABLE `t_grade` (
  `grade` varchar(10) DEFAULT NULL COMMENT '年级名称',
  `major` varchar(20) DEFAULT NULL COMMENT '专业',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_grade
-- ----------------------------
INSERT INTO `t_grade` VALUES ('2017', '软件工程', '1', '无');
INSERT INTO `t_grade` VALUES ('2017', '网络工程', '2', '无');
INSERT INTO `t_grade` VALUES ('2020', '人工智能', '3', '一本理科');
INSERT INTO `t_grade` VALUES ('2016', '软件工程', '5', '无');
INSERT INTO `t_grade` VALUES ('2016', '网络工程', '6', null);
INSERT INTO `t_grade` VALUES ('2016', '计算机科学', '7', null);
INSERT INTO `t_grade` VALUES ('2015', '软件工程', '8', null);
INSERT INTO `t_grade` VALUES ('2015', '网络工程', '9', null);
INSERT INTO `t_grade` VALUES ('2015', '物联网', '10', null);
INSERT INTO `t_grade` VALUES ('2014', '软件工程', '11', null);
INSERT INTO `t_grade` VALUES ('2014', '网络工程', '12', null);

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `sid` char(10) NOT NULL COMMENT '学号',
  `studentname` varchar(50) DEFAULT NULL COMMENT '学生姓名',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `region` varchar(100) DEFAULT NULL COMMENT '籍贯',
  `cid` int(11) DEFAULT NULL COMMENT '班级ID',
  `gid` int(11) DEFAULT NULL COMMENT '年级专业ID',
  `nationality` varchar(20) DEFAULT NULL COMMENT '民族',
  `politics` varchar(20) DEFAULT NULL COMMENT '政治面貌',
  `dorm` varchar(45) DEFAULT NULL COMMENT '宿舍号',
  `bank` varchar(100) DEFAULT NULL COMMENT '学校银行卡号',
  `id` char(18) DEFAULT NULL COMMENT '身份证号',
  `tel` char(11) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信',
  `weibo` varchar(50) DEFAULT NULL COMMENT '微博',
  `mother` varchar(20) DEFAULT NULL COMMENT '母亲',
  `mothertel` char(11) DEFAULT NULL COMMENT '母亲电话',
  `father` varchar(20) DEFAULT NULL COMMENT '父亲',
  `fathertel` char(11) DEFAULT NULL COMMENT '父亲电话',
  `residence` varchar(100) DEFAULT NULL COMMENT '户口',
  `home` varchar(100) DEFAULT NULL COMMENT '现居地址',
  `photo` varchar(100) DEFAULT NULL COMMENT '照片',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `status` varchar(20) DEFAULT NULL COMMENT '状态',
  `memo` varchar(100) DEFAULT NULL,
  `tid` char(8) DEFAULT NULL COMMENT '辅导员工号',
  PRIMARY KEY (`sid`),
  KEY `fk_cid` (`cid`),
  KEY `fk_gid1` (`gid`),
  KEY `fk_tid1` (`tid`),
  CONSTRAINT `fk_tid1` FOREIGN KEY (`tid`) REFERENCES `t_teacher` (`tid`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`cid`) REFERENCES `t_class` (`cid`),
  CONSTRAINT `fk_gid1` FOREIGN KEY (`gid`) REFERENCES `t_grade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('1712345678', '李明', '男', '河南', '1', '1', '汉族', '共青团员', '华苑1001', '160245617896', '410101022008010478', '13512347896', 'liming@henu.edu.cn', '89879521', 'liming123', 'limingweibo', '王丽', '13678948523', '李旭', '15096478965', '河南开封', '河南开封', '/1712345678.jpg', 'e1110aaadccc39994999baaa5999abbbbeee5666e0005777f2220fff88883eee', '在校', '', '10250001');

-- ----------------------------
-- Table structure for t_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `teachername` varchar(45) DEFAULT NULL COMMENT '教师姓名',
  `gender` char(2) DEFAULT NULL COMMENT '性别',
  `tid` char(8) NOT NULL COMMENT '工号',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `college` varchar(45) DEFAULT NULL COMMENT '所在院系',
  `tel` char(11) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信',
  `photo` varchar(50) DEFAULT NULL COMMENT '照片',
  `position` varchar(50) DEFAULT NULL COMMENT '职务',
  `admin` varchar(20) DEFAULT NULL COMMENT '是否管理员',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('张三', '男', '10250001', 'e1110aaadccc39994999baaa5999abbbbeee5666e0005777f2220fff88883eee', '软件学院', '13569981234', 'zhangsan@henu.edu.cn', '35634643', 'adsagsa', 'photo/10250001.jpg', null, '3');
INSERT INTO `t_teacher` VALUES ('李四', '女', '10250002', 'e3335cccf777b66664444999dfff56665fff9333c6660777d555a8881ddd0999', '软件学院', '13569981235', 'lisi@henu.edu.cn', '89536975', 'awtellls', 'photo/10250002.jpg', '讲师', '1');
