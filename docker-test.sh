#!/usr/bin/env bash

DOCKER_CONTAINER_ID=`docker run -d solutiondrive/docker-shopware-container:shopware$SHOPWARE_VERSION-php$PHP_VERSION`
inspec exec tests/inspec/shopware-container -t docker://${DOCKER_CONTAINER_ID}
