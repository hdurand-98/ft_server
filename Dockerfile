FROM	debian:buster-slim

RUN	apt-get update -y
RUN	apt install -y nginx \
		mariadb-server \
		mariadb-client \
		php-cgi \
		php-common \
		php-fpm \
		php-pear \
		php-mbstring \
		php-zip \
		php-net-socket \
		php-gd \
		php-xml \
		php-json \
		php-mysql \
		wget

COPY	srcs/mysql_setup.sh .
COPY	srcs/index_on.conf .
COPY	srcs/index_off.conf .
COPY	srcs/script.sh .
COPY	srcs/switch.sh .

#SSL certif
RUN	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=IDF/L=Paris/O=BloodyStream/CN=www.zeppeli.com' -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

#Nginx config
RUN	cp index_on.conf /etc/nginx/sites-enabled/
RUN	rm -rf /etc/nginx/sites-enabled/default


#Wordpress install
RUN	cd /var/www/html/ ; wget https://wordpress.org/latest.tar.gz ; 	tar -xvzf latest.tar.gz
COPY	srcs/wp-config.php /var/www/html/wordpress/.
RUN 	chown -R www-data:www-data /var/www/html/wordpress

#PHPMyAdmin setup
RUN	wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz ; tar -xvf phpMyAdmin-latest-all-languages.tar.gz --directory /var/www/html/
COPY	srcs/config.inc.php /var/www/html/phpMyAdmin-5.0.2-all-languages
RUN	rm /var/www/html/phpMyAdmin-5.0.2-all-languages/config.sample.inc.php
ENTRYPOINT ["bash", "/script.sh"]
