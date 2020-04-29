FROM centos:7

MAINTAINER joshi.ravishankar@gmail.com

# Install required repos, update, and then install PHP-FPM
RUN yum install -y epel-release \
    http://rpms.remirepo.net/enterprise/remi-release-7.rpm  yum-utils \
    && yum-config-manager --enable remi-php73 \
    && yum update -y \
    && yum install -y php-bcmath php-cli php-fpm php-mysqlnd php-mssql php-xml \
    php-pgsql php-gd php-mcrypt php-ldap php-imap php-soap php-tidy \
    php-mbstring php-opcache php-pdo php-pecl-apcu php-pecl-apcu-bc php-pecl-geoip \
    php-pecl-igbinary php-pecl-imagick php-pecl-redis unzip \
    && yum --enablerepo=epel install -y fcgi \
    && yum clean all

RUN yum install -y python-setuptools nginx && easy_install supervisor

# Configure nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-vars.ini /etc/php/conf.d/docker-vars.ini
RUN rm -rf /etc/php-fpm.d/www.conf
COPY www.conf /etc/php-fpm.d/pool.conf

#Configure supervisord
COPY supervisord.conf /etc/supervisord.conf
RUN mkdir /run/php-fpm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80 443

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf
