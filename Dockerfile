FROM php:7.0-apache
MAINTAINER Syouryuumaru <:noting>
RUN docker-php-ext-install mysqli && a2enmod rewrite
