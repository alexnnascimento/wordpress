FROM ubuntu:24.04

# Definir o DEBIAN_FRONTEND como noninteractive

RUN apt update -y
#ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y curl \
    wget \
    supervisor \
    unzip \
    nginx

RUN apt install -y php8.3 \
     php8.3-fpm \
     php8.3-cgi \
     php8.3-mysql \ 
     php8.3-curl	
#    php8.3-gd\
#    php8.3-xml\
#    php8.3-curl

# Reverter o DEBIAN_FRONTEND para não interferir em outras operações
#ENV DEBIAN_FRONTEND=dialog

# Copiar arquivos de configuração
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/nginx.conf /etc/nginx/nginx.config
COPY config/web.conf /etc/nginx/sites-enabled/web.conf
COPY config/php.ini /etc/php/8.3/fpm/php.ini

# Definindo diretório de trabalho
WORKDIR /var/www/html 

# Copiar arquivos do Wordpress 
COPY src/wordpress ./wordpress
COPY config/wp-config.php ./wordpress/wp-config.php

# Instalando e configurando composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer self-update
COPY config/composer.json ./composer.json
COPY /.env ./.env
RUN composer install 

#RUN chown -R www-data:www-data wordpress/ && \
#    find wordpress/ -type d -exec chmod 755 {} \; && \
#    find wordpress/ -type f -exec chmod 644 {} \;

# Comando para iniciar o supervisor

EXPOSE 80

CMD ["/usr/bin/supervisord"]

