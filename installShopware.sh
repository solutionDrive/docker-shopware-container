#!/usr/bin/env bash

declare -A KNOWNVERSIONS=(
    [5.5.2]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.5.2_92d78ee09d388d29f49cec3c82167ce803ee51b8.zip
    [5.4.6]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.4.6_f667f6471a77bb5af0c115f3e243594e6353747e.zip
    [5.3.7]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.3.7_741ae9fb77ecb227dc6be9c1028ded1e957c0e14.zip
    [5.2.27]=http://releases.s3.shopware.com.s3.amazonaws.com/install_5.2.27_56d5aabc56c2e48d84084d0381a72a3897d5263f.zip
)

if [ -z "${KNOWNVERSIONS[$SHOPWARE_VERSION]}" ]; then
    echo "This script does not know how to get shopware ${SHOPWARE_VERSION}"
    echo "Please create a pull request at 'https://github.com/solutiondrive/docker-shopware-container' and"
    echo "provide an url to get the requested version!"
    exit 1
fi
SHOPWARE_URL=${KNOWNVERSIONS[$SHOPWARE_VERSION]}

if [ -z "${PROJECT_HOME}" ]; then
    echo "$$PROJECT_HOME must be set!"
    exit 1
fi

mkdir -p ${PROJECT_HOME}

echo "Everything is configured, starting setup:"
echo "PHP_VERSION: ${PHP_VERSION}"
echo "SHOPWARE_VERSION: ${SHOPWARE_VERSION}"
echo "SHOPWARE_URL: ${SHOPWARE_URL}"
echo "PROJECT_HOME: ${PROJECT_HOME}"

cd ${PROJECT_HOME}

echo "Downloading shopware"
wget -q -O install.zip "${SHOPWARE_URL}"

echo "Unzipping install.zip"
unzip -q install.zip

chown -R www-data:www-data ${PROJECT_HOME}/
