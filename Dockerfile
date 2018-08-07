ARG PHP_VERSION
ARG SHOPWARE_VERSION

FROM solutiondrive/docker-php-container:php$PHP_VERSION

# Make it usable after FROM
ARG SHOPWARE_VERSION
ENV SHOPWARE_VERSION $SHOPWARE_VERSION
ENV PROJECT_HOME /var/www/shopware${SHOPWARE_VERSION}_php${PHP_VERSION}

ADD installShopware.sh /bin/installShopware.sh
RUN chmod +x /bin/installShopware.sh \
    && sync \
    && /bin/installShopware.sh
