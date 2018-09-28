-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        10.1.23-MariaDB - mariadb.org binary distribution
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 movie 的数据库结构
DROP DATABASE IF EXISTS `movie`;
CREATE DATABASE IF NOT EXISTS `movie` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `movie`;

-- 导出  表 movie.admin 结构
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `is_super` smallint(6) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `role_id` (`role_id`),
  KEY `ix_admin_addtime` (`addtime`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.admin 的数据：~2 rows (大约)
DELETE FROM `admin`;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`id`, `name`, `pwd`, `is_super`, `role_id`, `addtime`) VALUES
	(1, 'python', 'pbkdf2:sha256:50000$aeSB9WAY$1c23b755d24950d1a3854aae4d38d201e29bede241ae842802b07194daf35a1c', 0, 5, '2017-09-24 11:44:23'),
	(3, 'adc', 'pbkdf2:sha256:50000$oladkO2L$732ef57283f2ee998d30eecc95cfb28c65a3843b18e7417860fa87575a3f959d', NULL, NULL, '2017-10-14 11:32:18'),
	(4, 'test', 'pbkdf2:sha256:50000$azQqSj1Y$725ca817e2cb485a11ae4eefb871f25c2c38800f0e95b45fb67a22d4d2acdefe', 1, 10, '2018-09-06 11:09:24'),
	(5, 'zhanghai', 'pbkdf2:sha256:50000$25v4XW9p$b09be60cde4fb2ff4de36b41d792221624785eb4377a3cf07dfbf04ea024126b', 1, 5, '2018-09-07 11:21:51');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- 导出  表 movie.adminlog 结构
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE IF NOT EXISTS `adminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_adminlog_addtime` (`addtime`),
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.adminlog 的数据：~22 rows (大约)
DELETE FROM `adminlog`;
/*!40000 ALTER TABLE `adminlog` DISABLE KEYS */;
INSERT INTO `adminlog` (`id`, `admin_id`, `ip`, `addtime`) VALUES
	(1, 1, '127.0.0.1', '2018-06-22 11:30:06'),
	(2, 1, '127.0.0.1', '2018-08-27 16:50:52'),
	(3, 1, '127.0.0.1', '2018-08-27 17:08:24'),
	(4, 1, '127.0.0.1', '2018-08-27 17:10:34'),
	(5, 1, '127.0.0.1', '2018-08-27 17:27:40'),
	(6, 1, '127.0.0.1', '2018-08-29 16:21:06'),
	(7, 1, '127.0.0.1', '2018-08-29 16:21:48'),
	(8, 1, '127.0.0.1', '2018-09-06 11:05:35'),
	(9, 4, '127.0.0.1', '2018-09-06 11:12:04'),
	(10, 4, '127.0.0.1', '2018-09-06 11:23:40'),
	(11, 1, '127.0.0.1', '2018-09-06 11:25:01'),
	(12, 1, '127.0.0.1', '2018-09-06 11:25:21'),
	(13, 1, '127.0.0.1', '2018-09-06 11:25:31'),
	(14, 1, '127.0.0.1', '2018-09-07 11:04:59'),
	(15, 4, '127.0.0.1', '2018-09-07 11:06:00'),
	(16, 1, '127.0.0.1', '2018-09-07 11:13:28'),
	(17, 5, '127.0.0.1', '2018-09-07 11:22:55'),
	(18, 1, '127.0.0.1', '2018-09-08 13:55:15'),
	(19, 1, '127.0.0.1', '2018-09-08 16:08:47'),
	(20, 1, '127.0.0.1', '2018-09-28 09:38:08'),
	(21, 1, '127.0.0.1', '2018-09-28 09:38:47'),
	(22, 5, '127.0.0.1', '2018-09-28 09:39:15'),
	(23, 5, '127.0.0.1', '2018-09-28 09:45:02'),
	(24, 1, '127.0.0.1', '2018-09-28 09:49:01'),
	(25, 5, '127.0.0.1', '2018-09-28 16:15:28'),
	(26, 5, '127.0.0.1', '2018-09-28 16:17:26'),
	(27, 5, '127.0.0.1', '2018-09-28 16:18:40'),
	(28, 5, '127.0.0.1', '2018-09-28 16:19:07'),
	(29, 5, '127.0.0.1', '2018-09-28 16:20:23'),
	(30, 5, '127.0.0.1', '2018-09-28 16:28:31'),
	(31, 5, '127.0.0.1', '2018-09-28 16:29:05');
/*!40000 ALTER TABLE `adminlog` ENABLE KEYS */;

-- 导出  表 movie.auth 结构
DROP TABLE IF EXISTS `auth`;
CREATE TABLE IF NOT EXISTS `auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`),
  KEY `ix_auth_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.auth 的数据：~32 rows (大约)
DELETE FROM `auth`;
/*!40000 ALTER TABLE `auth` DISABLE KEYS */;
INSERT INTO `auth` (`id`, `name`, `url`, `addtime`) VALUES
	(1, '添加标签', '/admin/tag/add/', '2017-10-10 22:50:02'),
	(2, '编辑标签', '/admin/tag/edit/<int:id>/', '2017-10-10 22:50:46'),
	(3, '标签列表', '/admin/tag/list/<int:page>/', '2017-10-10 22:51:21'),
	(4, '删除标签', '/admin/tag/del/<int:id>/', '2017-10-10 22:51:48'),
	(5, '添加电影', '/admin/movie/add/', '2017-10-14 21:44:17'),
	(6, '电影列表', '/admin/movie/list/<int:page>/', '2017-10-14 21:44:38'),
	(7, '删除电影', '/admin/movie/del/<int:id>/', '2017-10-14 21:45:09'),
	(8, '电影编辑', '/admin/movie/edit/<int:id>/', '2017-10-14 21:45:30'),
	(9, '电影预告添加', '/admin/preview/add/', '2017-10-14 21:45:53'),
	(10, '电影预告列表', '/admin/preview/list/<int:page>/', '2017-10-14 21:46:16'),
	(11, '电影预告编辑', '/admin/preview/edit/<int:id>/', '2017-10-14 21:46:40'),
	(12, '电影预告删除', '/admin/preview/del/<int:id>/', '2017-10-14 21:47:16'),
	(13, '后台会员列表', '/admin/user/list/<int:page>/', '2017-10-14 21:47:56'),
	(14, '后台会员详情', '/admin/user/view/<int:id>/', '2017-10-14 21:48:24'),
	(15, '后台会员删除', '/admin/user/del/<int:id>/', '2017-10-14 21:48:39'),
	(17, '评论详情列表', '/admin/comment/list/<int:page>/', '2017-10-14 21:50:14'),
	(18, '评论删除', '/admin/comment/del/<int:id>/', '2017-10-14 21:50:31'),
	(19, '电影收藏列表', '/admin/moviecol/list/<int:page>/', '2017-10-14 21:50:57'),
	(20, '电影收藏删除', '/admin/moviecol/del/<int:id>', '2017-10-14 21:51:33'),
	(21, '后台操作日志', '/admin/oplog/list/<int:page>/', '2017-10-14 21:52:13'),
	(22, '后台登陆日志', '/admin/adminloginlog/list/<int:page>/', '2017-10-14 21:52:56'),
	(23, '后台会员登陆日志', '/admin/userloginlog/list/<int:page>/', '2017-10-14 21:53:19'),
	(24, '后台角色添加', '/admin/role/add/', '2017-10-14 21:53:45'),
	(25, '后台角色列表', '/admin/role/list/<int:page>/', '2017-10-14 21:54:04'),
	(26, '后台角色删除', '/admin/role/del/<int:id>', '2017-10-14 21:54:19'),
	(27, '后台角色编辑', '/admin/role/edit/<int:id>', '2017-10-14 21:54:40'),
	(28, '后台权限添加', '/admin/auth/add/', '2017-10-14 21:55:02'),
	(29, '后台权限列表', '/admin/auth/list/<int:page>', '2017-10-14 21:55:17'),
	(30, '后台权限删除', '/admin/auth/del/<int:id>', '2017-10-14 21:55:31'),
	(31, '后台权限编辑', '/admin/auth/edit/<int:id>', '2017-10-14 21:55:46'),
	(32, '后台管理员添加', '/admin/admin/add/', '2017-10-14 21:56:04'),
	(33, '后台管理员列表', '/admin/admin/list/<int:page>', '2017-10-14 21:56:19');
/*!40000 ALTER TABLE `auth` ENABLE KEYS */;

-- 导出  表 movie.comment 结构
DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_comment_addtime` (`addtime`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.comment 的数据：~15 rows (大约)
DELETE FROM `comment`;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`id`, `content`, `movie_id`, `user_id`, `addtime`) VALUES
	(2, '好看', 7, 1, '2017-09-24 12:21:11'),
	(3, '不错', 7, 2, '2017-09-24 12:21:11'),
	(4, '经典', 7, 3, '2017-09-24 12:21:11'),
	(5, '给力', 7, 4, '2017-09-24 12:21:11'),
	(9, '给力', 2, 4, '2017-09-24 12:21:54'),
	(10, '难看', 3, 6, '2017-09-24 12:21:54'),
	(11, '无聊', 5, 5, '2017-09-24 12:21:54'),
	(12, '乏味', 2, 4, '2017-09-24 12:21:54'),
	(13, '<p><img src="http://img.baidu.com/hi/jx2/j_0002.gif"/></p>', 3, 15, '2017-10-18 23:27:44'),
	(14, '<p><img src="http://img.baidu.com/hi/jx2/j_0008.gif"/></p>', 3, 15, '2017-10-18 23:28:07'),
	(15, '<p><img src="http://img.baidu.com/hi/jx2/j_0071.gif"/></p>', 4, 15, '2017-10-18 23:41:29'),
	(16, '<p><img src="http://img.baidu.com/hi/jx2/j_0074.gif"/></p>', 4, 15, '2017-10-18 23:41:34'),
	(18, '<p>sefwefwefsdfsdfdsfsdfsdfsdfdsfdfsffdsfdsf</p>', 5, NULL, '2017-10-19 16:22:25'),
	(19, '<p><img src="http://img.baidu.com/hi/jx2/j_0017.gif"/></p>', 2, NULL, '2017-10-19 17:33:35'),
	(20, '<p><img src="http://img.baidu.com/hi/jx2/j_0073.gif"/></p>', 2, NULL, '2017-10-19 17:33:51');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;

-- 导出  表 movie.movie 结构
DROP TABLE IF EXISTS `movie`;
CREATE TABLE IF NOT EXISTS `movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `info` text,
  `logo` varchar(255) DEFAULT NULL,
  `star` smallint(6) DEFAULT NULL,
  `playnum` bigint(20) DEFAULT NULL,
  `commentnum` bigint(20) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `release_time` date DEFAULT NULL,
  `length` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `creater_id` int(11) DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `url` (`url`),
  UNIQUE KEY `logo` (`logo`),
  KEY `tag_id` (`tag_id`),
  KEY `ix_movie_addtime` (`addtime`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.movie 的数据：~9 rows (大约)
DELETE FROM `movie`;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` (`id`, `title`, `url`, `info`, `logo`, `star`, `playnum`, `commentnum`, `tag_id`, `area`, `release_time`, `length`, `addtime`, `creater_id`) VALUES
	(1, '测试一号', '20170924115331f1ff8e7641f24743a2f5667366d73d5d.mp4', '测试一号', '20170924115331b5cb0c43fd3047e6886554a9c71b1786.jpg', 1, 3, 0, 1, '测试一号', '2017-09-28', '100', '2017-09-24 11:53:32', NULL),
	(2, '测试二号', '2017092411541082b8cd549c4649ff9bcac4879ddc72b3.mp4', '测试二号', '20170924115410c3a22e9358224a0786f62cda02f9665e.jpg', 2, 8, 0, 2, '测试二号', '2017-09-30', '100', '2017-09-24 11:54:11', NULL),
	(3, '测试三号', '2017092411544778a4506801b14c75a9b2932a629486a8.mp4', '测试三号', '20170924115447f3afc07ad1254b0bb2ac7b9cc7ca878d.jpg', 3, 13, 0, 4, '测试三号', '2017-09-25', '100', '2017-09-24 11:54:47', NULL),
	(4, '测试四号', '201709241155161f1da3fce4ae4795a06872fb9aa7f2cc.mp4', '测试四号', '20170924115516c20aa7753d294c7caf80832b8616aa94.jpg', 4, 5, 0, 4, '测试四号', '2017-09-16', '100', '2017-09-24 11:55:16', NULL),
	(5, '测试五号', '20170924115546f34bdd45d0364c0eadafe1d64e254795.mp4', '测试五号', '2017092411554656316d74289b4501ad4de7b7eca6b95b.jpg', 5, 7, 0, 5, '测试五号', '2017-09-08', '100', '2017-09-24 11:55:46', NULL),
	(6, '测试七号', '20170924121808482010bbffa1424d82c505a1984a85c0.mp4', '测试七号', '20170924121808e628713cc0974aa6a319ffe8f2d7a227.jpg', 1, 4, 0, 8, '测试七号', '2017-09-20', '100', '2017-09-24 12:18:08', NULL),
	(7, '测试八号', '20170924121835795fee43c4694a26a8fe4248dcb7d980.mp4', '测试八号', '2017092412183501cb379afec841d9984b5cde5f011db6.jpg', 1, 2, 0, 1, '测试八号', '2017-09-10', '100', '2017-09-24 12:18:36', NULL),
	(8, '战狼', '20180908140112_fc9b2168e76541e9892a23a25caa9124.mp4', '第一次上传', '20180908140113_6b93adabb6d04622a61f90066e1ab881.PNG', 5, 0, 0, 1, '欧美', '2018-09-01', '100', '2018-09-08 14:01:20', NULL),
	(9, '战狼2', '20180908141456_1e7bf02ce42e4d6e86b71f4544d77149.mp4', '战狼2', '20180908141456_ca864ec9469241448278e153effcb006.PNG', 5, 0, 0, 1, '欧美', '2018-09-02', '100', '2018-09-08 14:14:56', NULL),
	(10, '战狼3', '20180908142032_f1075b1648604d6abc112bda97df78e8.mp4', '战狼3', '20180908142032_e94df5df554b4dafbfd22620d7e3c32b.PNG', 5, 0, 0, 5, '欧美', '2018-09-03', '100', '2018-09-08 14:20:32', 1);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;

-- 导出  表 movie.moviecol 结构
DROP TABLE IF EXISTS `moviecol`;
CREATE TABLE IF NOT EXISTS `moviecol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_moviecol_addtime` (`addtime`),
  CONSTRAINT `moviecol_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `moviecol_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.moviecol 的数据：~0 rows (大约)
DELETE FROM `moviecol`;
/*!40000 ALTER TABLE `moviecol` DISABLE KEYS */;
INSERT INTO `moviecol` (`id`, `movie_id`, `user_id`, `addtime`) VALUES
	(1, 6, NULL, '2017-10-23 17:34:39');
/*!40000 ALTER TABLE `moviecol` ENABLE KEYS */;

-- 导出  表 movie.oplog 结构
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE IF NOT EXISTS `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `reason` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_oplog_addtime` (`addtime`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.oplog 的数据：~6 rows (大约)
DELETE FROM `oplog`;
/*!40000 ALTER TABLE `oplog` DISABLE KEYS */;
INSERT INTO `oplog` (`id`, `admin_id`, `ip`, `reason`, `addtime`) VALUES
	(1, 1, '127.0.0.1', '添加标签56', '2017-10-09 23:55:11'),
	(2, 1, '127.0.0.1', '添加新管理员：test', '2018-09-06 11:09:24'),
	(3, 1, '127.0.0.1', '添加新管理员：zhanghai', '2018-09-07 11:21:51'),
	(4, 5, '127.0.0.1', '删除会员「zfc(14)」在《测试五号》的评论：<p><img src="http://img.baidu.com/hi/jx2/j_0006.gif"/></p>', '2018-09-07 11:25:56'),
	(5, 1, '127.0.0.1', '添加新电影：战狼', '2018-09-08 14:01:21'),
	(6, 1, '127.0.0.1', '添加新电影：战狼2', '2018-09-08 14:14:56'),
	(7, 1, '127.0.0.1', '添加新电影：战狼3', '2018-09-08 14:20:32');
/*!40000 ALTER TABLE `oplog` ENABLE KEYS */;

-- 导出  表 movie.preview 结构
DROP TABLE IF EXISTS `preview`;
CREATE TABLE IF NOT EXISTS `preview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `logo` (`logo`),
  KEY `ix_preview_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.preview 的数据：~8 rows (大约)
DELETE FROM `preview`;
/*!40000 ALTER TABLE `preview` DISABLE KEYS */;
INSERT INTO `preview` (`id`, `title`, `logo`, `addtime`) VALUES
	(1, '测试八号', '2017092412185876f6a3f26e124dde937ca2887dcebe02.jpg', '2017-09-24 12:18:59'),
	(2, '测试七号', '201709241219107ebedeb851af4ea9ae6ae5739b2aef4f.jpg', '2017-09-24 12:19:11'),
	(3, '测试六号', '20170924121921c1562c108835463c803e8b224ab486b6.jpg', '2017-09-24 12:19:22'),
	(4, '测试五号', '20170924121930c2fe2258de0d4b54adf8f34ce4c4f8e3.jpg', '2017-09-24 12:19:31'),
	(5, '测试四号', '2017092412194346b91f460bd846afbced2558e1cbf7aa.jpg', '2017-09-24 12:19:44'),
	(6, '测试三号', '20170924121953fcef4c90e7d04896b936c79bf92dfb61.jpg', '2017-09-24 12:19:54'),
	(7, '测试二号', '20170924122004e3932c4f15494ba6aaac80f9edf26ab1.jpg', '2017-09-24 12:20:04'),
	(8, '测试一号', '20170924122014887c8af5047e49e7b8da2707fc942c5c.jpg', '2017-09-24 12:20:14');
/*!40000 ALTER TABLE `preview` ENABLE KEYS */;

-- 导出  表 movie.role 结构
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `auths` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_role_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.role 的数据：~9 rows (大约)
DELETE FROM `role`;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `name`, `auths`, `addtime`) VALUES
	(5, '超级管理员->具备所有功能', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33', '2017-10-14 22:03:34'),
	(6, '标签管理员', '1,2,3,4', '2017-10-14 22:06:39'),
	(7, '电影管理员', '5,6,7,8,9,10,11,12', '2017-10-14 22:07:05'),
	(8, '会员管理员', '13,14,15', '2017-10-14 22:07:27'),
	(9, '评论管理员', '17,18', '2017-10-14 22:07:44'),
	(10, '日志管理员', '21,22,23', '2017-10-14 22:08:20'),
	(11, '角色管理员', '24,25,26,27', '2017-10-14 22:08:55'),
	(12, '权限管理员', '28,29,30,31', '2017-10-14 22:09:22'),
	(13, '管理员', '32,33', '2017-10-14 22:09:37');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

-- 导出  表 movie.tag 结构
DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_tag_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.tag 的数据：~23 rows (大约)
DELETE FROM `tag`;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` (`id`, `name`, `addtime`) VALUES
	(1, '现代', '2017-09-24 11:51:13'),
	(2, '恐怖', '2017-09-24 11:51:17'),
	(3, '言情', '2017-09-24 11:51:22'),
	(4, '玄幻', '2017-09-24 11:51:29'),
	(5, '惊恐', '2017-09-24 11:51:34'),
	(6, '警匪', '2017-09-24 11:51:40'),
	(7, '香港', '2017-09-24 11:51:48'),
	(8, '美剧', '2017-09-24 11:51:52'),
	(10, '项目入驻 - 基本信息', NULL),
	(11, '现代5', NULL),
	(13, 'gtryu', NULL),
	(15, 'ds', '2017-09-26 10:32:30'),
	(16, 'afsdfds', '2017-09-26 10:33:30'),
	(19, '665', NULL),
	(20, '9', NULL),
	(21, '99', NULL),
	(22, 'qwe', NULL),
	(23, 'qwe33', NULL),
	(24, 'qwe336', NULL),
	(25, 'qwe336999', NULL),
	(27, 'poi', NULL),
	(28, 'dasdas', '2017-10-09 23:54:50'),
	(29, '56', '2017-10-09 23:55:11');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;

-- 导出  表 movie.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `info` text,
  `face` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `face` (`face`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_user_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.user 的数据：~15 rows (大约)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `name`, `pwd`, `email`, `phone`, `info`, `face`, `addtime`, `uuid`) VALUES
	(1, '鼠', '1231', '1231@123.com', '13888888881', '鼠', '1f401.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc0'),
	(2, '牛', '1232', '1232@123.com', '13888888882', '牛', '1f402.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc1'),
	(3, '虎', '1233', '1233@123.com', '13888888883', '虎', '1f405.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc2'),
	(4, '兔', '1234', '1234@123.com', '13888888884', '兔', '1f407.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc3'),
	(5, '龙', '1235', '1235@123.com', '13888888885', '龙', '1f409.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc4'),
	(6, '蛇', '1236', '1236@123.com', '13888888886', '蛇', '1f40d.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc5'),
	(7, '马', '1237', '1237@123.com', '13888888887', '马', '1f434.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc6'),
	(8, '羊', '1238', '1238@123.com', '13888888888', '羊', '1f411.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc7'),
	(9, '猴', '1239', '1239@123.com', '13888888889', '猴', '1f412.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc8'),
	(10, '鸡', '1240', '1240@123.com', '13888888891', '鸡', '1f413.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fc9'),
	(11, '狗', '1241', '1241@123.com', '13888888892', '狗', '1f415.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fd0'),
	(12, '猪', '1242', '1242@123.com', '13888888893', '猪', '1f416.png', '2017-09-24 11:46:26', 'd32a72bdac524478b7e4f6dfc8394fd1'),
	(13, 'admin', 'pbkdf2:sha256:50000$tl2m2yqm$b4ba5451a549686d785fe01cd533955ddb23b69a74b2ed5c7e0680210b1e8368', 'aa931912343@qq.com', '13865516434', '修改信息', '20171015193301d2232cb9ab7c4f39a8710b10aee83c04.jpg', '2017-10-15 16:21:22', '25fe3f2c9e484de0a08777278ca032c4'),
	(15, 'admin1', 'pbkdf2:sha256:50000$pPKJkgkU$f0732f644233981458e5aba72d115218d51397fda94fd67f4d3fe7abb951cf1c', 'a31912343@qq.com', '13865516439', NULL, NULL, '2017-10-18 23:26:32', '781aad9e4f99402793d3718ef8a7af3f');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 导出  表 movie.userlog 结构
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE IF NOT EXISTS `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_userlog_addtime` (`addtime`),
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- 正在导出表  movie.userlog 的数据：~27 rows (大约)
DELETE FROM `userlog`;
/*!40000 ALTER TABLE `userlog` DISABLE KEYS */;
INSERT INTO `userlog` (`id`, `user_id`, `ip`, `addtime`) VALUES
	(1, 1, '192.168.4.1', '2017-09-24 11:47:39'),
	(2, 2, '192.168.4.2', '2017-09-24 11:47:39'),
	(3, 3, '192.168.4.3', '2017-09-24 11:47:39'),
	(4, 4, '192.168.4.4', '2017-09-24 11:47:39'),
	(5, 5, '192.168.4.5', '2017-09-24 11:47:39'),
	(6, 6, '192.168.4.6', '2017-09-24 11:47:39'),
	(7, 7, '192.168.4.7', '2017-09-24 11:47:39'),
	(8, 8, '192.168.4.8', '2017-09-24 11:47:39'),
	(9, 9, '192.168.4.9', '2017-09-24 11:47:39'),
	(10, 13, '127.0.0.1', '2017-10-15 16:54:51'),
	(11, 13, '127.0.0.1', '2017-10-15 17:02:37'),
	(12, 13, '127.0.0.1', '2017-10-15 17:04:23'),
	(13, 13, '127.0.0.1', '2017-10-15 17:04:54'),
	(14, 13, '127.0.0.1', '2017-10-15 17:05:46'),
	(15, 13, '127.0.0.1', '2017-10-15 17:06:23'),
	(16, 13, '127.0.0.1', '2017-10-15 19:00:41'),
	(17, 13, '127.0.0.1', '2017-10-15 19:35:19'),
	(18, 13, '127.0.0.1', '2017-10-15 20:33:18'),
	(19, 13, '127.0.0.1', '2017-10-15 21:01:02'),
	(20, NULL, '127.0.0.1', '2017-10-15 21:03:45'),
	(21, NULL, '127.0.0.1', '2017-10-15 21:32:58'),
	(22, NULL, '127.0.0.1', '2017-10-15 21:33:27'),
	(23, 13, '127.0.0.1', '2017-10-15 21:46:39'),
	(24, 15, '127.0.0.1', '2017-10-18 23:26:38'),
	(25, NULL, '127.0.0.1', '2017-10-19 16:20:22'),
	(26, NULL, '127.0.0.1', '2017-10-23 17:29:52'),
	(27, 13, '127.0.0.1', '2018-08-27 16:40:21');
/*!40000 ALTER TABLE `userlog` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
