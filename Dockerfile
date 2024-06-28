FROM ubuntu:24.04

RUN apt update -y

# Definir o DEBIAN_FRONTEND como noninteractive
#ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y curl \
    wget \
    supervisor \ 
    nginx

# Instalação do php
RUN apt install -y php8.3 \
     php8.3-fpm \
     php8.3-cgi \
     php8.3-mysql 
#    php8.1-gd\
#    php8.1-xml\
#    php8.1-curl

# Reverter o DEBIAN_FRONTEND para não interferir em outras operações
#ENV DEBIAN_FRONTEND=dialog

# Copiar os arquivos de configuração par ao container
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/nginx.conf /etc/nginx/nginx.config
COPY config/web.conf /etc/nginx/sites-enabled/web.conf
COPY config/php.ini /etc/php/8.3/fpm/php.ini

#Define o diretório de trabalho
WORKDIR /var/www/html 

#Copia o código-fonte do Wordpress
COPY src/wordpress ./wordpress

#RUN chown -R www-data:www-data wordpress/ && \
#    find wordpress/ -type d -exec chmod 755 {} \; && \
#    find wordpress/ -type f -exec chmod 644 {} \;

EXPOSE 80

# Comando para iniciar o supervisor
CMD ["/usr/bin/supervisord"]

