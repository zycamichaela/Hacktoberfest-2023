FROM php:5.6-apache
RUN a2enmod rewrite
# install the PHP extensions we need
RUN apt-get update &amp;&amp; apt-get install -y libpng12-dev libjpeg-dev &amp;&amp; rm -rf /var/lib/apt/lists/* \
  &amp;&amp; docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  &amp;&amp; docker-php-ext-install gd RUN docker-php-ext-install mysqli
VOLUME /var/www/html
ENV WORDPRESS_VERSION 4.2.2
ENV WORDPRESS_UPSTREAM_VERSION 4.2.2
ENV WORDPRESS_SHA1 d3a70d0f116e6afea5b850f793a81a97d2115039
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_UPSTREAM_VERSION}.tar.gz \
  &amp;&amp; echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
  &amp;&amp; tar -xzf wordpress.tar.gz -C /usr/src/ \
  &amp;&amp; rm wordpress.tar.gz \
  &amp;&amp; chown -R www-data:www-data /usr/src/wordpress
COPY docker-entrypoint.sh /entrypoint.sh
# grr, ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
FROM MAINTAINER SYOURYUUMARU