# Install LAMP
apt-get install apache2 php php-mysql php-gd php-mcrypt php-mbstring mariadb-server
mysql_secure_installation

# Enable mods
a2enmod ssl rewrite

# Enable ssl site
a2ensite default-ssl

# Start services
service apache2 start
service mysql start

# Or
/etc/init.d/apache2 start
/etc/init.d/mysql start
