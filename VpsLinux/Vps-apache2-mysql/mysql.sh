# Login to mysql
mysql -u root -p

# Create database
mysql> CREATE DATABASE roundcubemail /*!40101 CHARACTER SET utf8 COLLATE utf8_general_ci */;

# Create user
mysql> CREATE USER 'roundcube'@'localhost' IDENTIFIED BY 'password';

# Privileges
mysql> GRANT ALL PRIVILEGES ON roundcubemail.* to 'roundcube'@'localhost';

# Refresh mysql
mysql> FLUSH PRIVILEGES;

#Exit
mysql> EXIT
mysql> QUIT

# Backup all mysql database
mysqldump -u root -p --all-databases > file.sql

# Or multiple databases
mysqldump -u root -p --databases db1 db2 db3 > file.sql

# Or single database
mysqldump -u root -p  db1 > file.sql

# Import database
mysql -u root -p < file.sql


# Create database and table example

CREATE DATABASE IF NOT EXISTS `qflash` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `qflash`;

DROP TABLE IF EXISTS `users`;

CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(21) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `pass` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',  
  `price` decimal(11,2) NOT NULL DEFAULT '0.00',
  `year` int(11) NOT NULL DEFAULT '0',
  `about` text,  
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` int(1) NOT NULL DEFAULT '1',
  `ban` int(1) NOT NULL DEFAULT '0',
  `ip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(32) NOT NULL DEFAULT 'abc321',  
  `type` int(1) NOT NULL DEFAULT '1',
  `apikey` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `apipass` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),  
  UNIQUE KEY `ukey` (`username`)
  UNIQUE KEY `userkey` (`username`, `email`),  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# FOREIGN KEY example
# FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE

