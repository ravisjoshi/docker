FROM centos:7

MAINTAINER joshi.ravishankar@gmail.com

# Install required repos, update, and then install PHP-FPM
RUN yum install -y epel-release \
        http://rpms.remirepo.net/enterprise/remi-release-7.rpm  yum-utils \
        && yum-config-manager --enable remi-php70 \
        && yum install -y php-bcmath php-cli php-fpm php-mysqlnd php-mssql php-xml \
        php-pgsql php-gd php-mcrypt php-ldap php-imap php-soap php-tidy \
        php-mbstring php-opcache php-pdo php-pecl-apcu php-pecl-apcu-bc php-pecl-geoip \
        php-pecl-igbinary php-pecl-imagick php-pecl-redis unzip \
        && yum --enablerepo=epel install -y fcgi \
        && yum clean all

RUN yum install -y autoconf gcc musl-dev make mongodb nginx && easy_install supervisor

RUN touch /etc/php.d/php-ext-mongodb.ini && echo "extension=mongodb.so" > /etc/php.d/php-ext-mongodb.ini

COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/supervisord.service /usr/lib/systemd/system/supervisord.service
COPY nginx.conf /etc/nginx/nginx.conf

RUN supervisorctl restart nginx

ADD . /var/www/html

RUN cd /var/www/html && composer require mongodb/mongodb --update-with-all-dependencies

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
