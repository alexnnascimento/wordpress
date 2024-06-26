FROM ubuntu:22.04

# Definir o DEBIAN_FRONTEND como noninteractive

RUN apt update -y
ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y curl \
    wget \
    supervisor

RUN apt install -y php8.1 \
     php8.1-fpm \
     php8.1-cgi \
     php8.1-mysql 
#    php8.1-gd\
#    php8.1-xml\
#    php8.1-curl

# Reverter o DEBIAN_FRONTEND para não interferir em outras operações
ENV DEBIAN_FRONTEND=dialog

RUN apt install -y nginx 

# Copiar o arquivo de configuração do supervisord para o contêiner
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY config/nginx.conf /etc/nginx/nginx.config

COPY config/web.conf /etc/nginx/sites-enabled/web.conf

COPY config/php.ini /etc/php/8.1/fpm/php.ini

WORKDIR /var/www/html 

COPY src/wordpress ./wordpress

#RUN chown -R www-data:www-data wordpress/ && \
#    find wordpress/ -type d -exec chmod 755 {} \; && \
#    find wordpress/ -type f -exec chmod 644 {} \;

# Comando para iniciar o supervisor

EXPOSE 80

CMD ["/usr/bin/supervisord"]

