# docker-shopware-container

Docker container with installed shopware

## Environment variables

There are some environment variables which should be available during startup:

    DB_DATABASE

This variable defines for which database this shopware installation should be configured. (default: test)
It is important to use different databases per shopware container.

    WEB_HOST

This variable will be used to initialize the shop for the correct url. (default: localhost)
It is important to use different hosts per shopware container.


Also the following environment variables will be considered during startup:

    DB_HOST

Host on which your database is running. (default: mysql)

    DB_PORT

Port on which your database is listening. (default: 3306)

    DB_USERNAME

Username which will be used to connect to your database. (default: root)

    DB_PASSWORD

Password which will be used to connect to your database. (default: root)

### Force installation

The installation of shopware is only done on the first start of the container!
An installation can be forced with the following environment variable:

    FORCE_INSTALL

If this variable has a value then the install process will be triggered.

## License

See LICENSE file
