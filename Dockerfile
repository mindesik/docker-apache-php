FROM debian:latest
MAINTAINER Eugene Min <e.min@milax.com>

RUN apt-get update -y && apt-get install -y wget nano apache2 php5 php5-mysql
RUN a2enmod rewrite
RUN rm /etc/apache2/sites-available/000-default.conf
COPY ./conf/000-default.conf /etc/apache2/sites-available/000-default.conf
ENV DEBIAN_FRONTEND noninteractive
RUN echo "apache ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN rm -rf /var/www/html/*
VOLUME ["/var/www/html"]
WORKDIR /var/www/html
EXPOSE 80 443
ENTRYPOINT service apache2 restart && tail -f /var/log/apache2/*