FROM debian:sid
MAINTAINER pronav <pranavguptarulz@gmail.com>

COPY conf/01_nodoc /etc/dpkg/dpkg.cfg.d/

RUN rm -rf /usr/share/{doc,man,locale,i18n,info} \
  && echo deb http://debianmirror.nkn.in/debian sid main > /etc/apt/sources.list \
  && apt-get update && apt-get install -y --no-install-recommends \
    awscli \
    openjdk-8-jre-headless \
    curl \
    gnupg2 \
  && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs --no-install-recommends \
  && npm install -g gulp \
  && apt-get purge -y gnupg2 && apt autoremove -y \
  && rm -rf /etc/apt/sources.list.d \
  && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    php \
    composer \
    phpunit \
    php-mysql \
    mariadb-server \
    xvfb \
    chromium \
    chromedriver \
    fluxbox \
    x11vnc \
    xterm \
    nano \
  && rm -rf /usr/share/fluxbox/nls \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    firefox \
    lsof \
    procps \
    php-mbstring \
    php-curl \
    php-zip \
    php-mcrypt \
  && rm -rf /var/lib/apt/lists/*

RUN echo 1bcf108858b5422ba05da11b9c7de8ba > /etc/machine-id

COPY conf/fluxbox/* /etc/X11/fluxbox/
COPY files/* /

ENTRYPOINT ["/entrypoint.sh"]