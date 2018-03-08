# Install LAMP
apt-get install apache2 php php-mysql php-gd php-mcrypt php-mbstring mariadb-server

# For roundcube see here https://www.digitalocean.com/community/tutorials/how-to-install-your-own-webmail-client-with-roundcube-on-ubuntu-16-04
apt-get install php-xml php-intl php-zip php-pear zip unzip

# Secure mysql
mysql_secure_installation

# Pip ini config file
/etc/php/7.0/apache2/php.ini

# Change it
# Time zone
# date.timezone = "America/New_York"
date.timezone = "Europe/Warsaw"
# Upload file max size
upload_max_filesize = 15M
post_max_size = 18M
# mbstrings
mbstring.func_overload = 0
# Enable extensions
extension=php_curl.dll
extension=php_gd2.dll
extension=php_imap.dll
extension=php_ldap.dll
extension=php_openssl.dll
extension=php_pdo_mysql.dll
extension=php_sockets.dll
extension=php_mbstring.dll
extension=php_xmlrpc.dll
extension=dom.so

# Apache2 folder for virtual.host.conf file with sites
/etc/apache2/sites-available

# Enable mods
a2enmod ssl rewrite

# Enable ssl site
a2ensite default-ssl

# Chmods for all folder
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Start services
service apache2 start
service mysql start

# Or
/etc/init.d/apache2 start
/etc/init.d/mysql start
