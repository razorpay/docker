FROM php:5.6 

# Install required linux packages 
RUN apt-get update -y && \
    apt-get install -y libmcrypt-dev libssl-dev git-core libsqlite3-dev libmysqlclient18 python-pip libgd3 libpng3 libpng3-dev libjpeg62

# Install php extensions 
RUN docker-php-ext-install mcrypt mbstring zip pcntl pdo_sqlite pdo_mysql gd

# Install awscli to help in aws deployments 
RUN pip install awscli

# Install composer 
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

