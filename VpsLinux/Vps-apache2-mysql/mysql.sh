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
