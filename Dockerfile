ARG PHP_VERSION

FROM solutiondrive/docker-php-container:php$PHP_VERSION

# Make it usable after FROM
ARG SHOPWARE_VERSION
ARG SHOPWARE_SHORT_VERSION
ARG PHP_SHORT_VERSION
ENV SHOPWARE_VERSION $SHOPWARE_VERSION
ENV PROJECT_HOME /var/www/shopware${SHOPWARE_SHORT_VERSION}_php${PHP_SHORT_VERSION}

ADD installShopware.sh /bin/installShopware.sh
RUN chmod +x /bin/installShopware.sh \
    && sync \
    && /bin/installShopware.sh

COPY configureAndInitializeShopware.sh /bin/configureAndInitializeShopware.sh

ENTRYPOINT ["/bin/configureAndInitializeShopware.sh", "docker-php-entrypoint"]
CMD ["php-fpm"]
