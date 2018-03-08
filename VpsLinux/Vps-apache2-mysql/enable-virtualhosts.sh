# Domain folder
/var/www/html/breakermind.com

# insert ssl files for domain in folder
/var/www/ssl/breakermind.com/certificate.crt
/var/www/ssl/breakermind.com/private.key
/var/www/ssl/breakermind.com/ca_bundle.crt

# Chmods for all folder
chown www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Or only for uplaods folders in domain
chown www-data:www-data /var/www/html/breakermind.com/media
chmod -R 755 /var/www/html/breakermind.com/media

# Disable sites
a2dissite 000-default
a2dissite default-ssl

# Enable sites
a2ensite virtual.host

# Enable mods
a2enmod ssl rewrite

# Restart
service apache2 restart
/etc/init.d/apache2 restart

# Stop
service apache2 stop
/etc/init.d/apache2 stop

# Start
service apache2 start
/etc/init.d/apache2 start
