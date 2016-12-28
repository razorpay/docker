FROM debian:sid
MAINTAINER pronav <pranavguptarulz@gmail.com>

COPY conf/01_nodoc /etc/dpkg/dpkg.cfg.d/

RUN rm -rf /usr/share/{doc,man,locale,i18n,info} \
  && echo deb http://debianmirror.nkn.in/debian sid main > /etc/apt/sources.list \
  && apt-get update && apt-get install -y --no-install-recommends \
    awscli \
    openjdk-8-jre-headless \
    curl \
    git \
    openssh-client \
    gnupg2 \
  && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs --no-install-recommends \
  && apt-get install yarn \
  && yarn global add gulp \
  && apt-get purge -y gnupg2 && apt autoremove -y \
  && rm -rf /etc/apt/sources.list.d \
  && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    php \
    composer \
    phpunit \
    php-mysql \
    mariadb-server \
    lsof \
    php-mbstring \
    php-curl \
    php-zip \
    php-mcrypt \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    firefox-esr \
  && echo bbd4526aec61483a88ce65edef6615d7 > /etc/machine-id \
  && rm -rf /var/lib/apt/lists/*

COPY files/* /

ENTRYPOINT ["/entrypoint.sh"]
