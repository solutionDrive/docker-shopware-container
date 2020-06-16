#!/usr/bin/env bash

set -e

docker build \
    --build-arg PHP_VERSION=$PHP_VERSION \
    --build-arg PHP_SHORT_VERSION=$PHP_SHORT_VERSION \
    --build-arg SHOPWARE_VERSION=$SHOPWARE_VERSION \
    --build-arg SHOPWARE_SHORT_VERSION=$SHOPWARE_SHORT_VERSION \
    -t solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION \
    .

docker tag \
    solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION \
    solutiondrive/shopware:shopware$SHOPWARE_VERSION-php$PHP_VERSION

# Tag "latest"
if [ "$LATEST" = "1" ]; then
    docker tag \
        solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION \
        solutiondrive/docker-shopware-container:latest

    docker tag \
        solutiondrive/docker-shopware-container:latest
        solutiondrive/shopware:latest
fi
