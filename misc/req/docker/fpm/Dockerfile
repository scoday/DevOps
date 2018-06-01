FROM php:7-fpm-alpine3.7

COPY index.php /usr/local/apache2/htdocs/index.php

USER www-data:www-data

ENTRYPOINT ["php-fpm"]
