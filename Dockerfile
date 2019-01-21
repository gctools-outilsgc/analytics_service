FROM bitnami/minideb-extras:stretch-r227
LABEL maintainer "Bitnami <containers@bitnami.com> + Addison van den Hoeven <addison.vandenhoeven@tbs-sct.gc.ca>"

# copy the config files over
COPY config /

# Install required system packages and dependencies for bitnami stuff
RUN install_packages libbz2-1.0 libc6 libcomerr2 libcurl3 libexpat1 libffi6 libfreetype6 libgcc1 libgcrypt20 libgmp10 libgnutls30 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu57 libidn11 libidn2-0 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-2.4-2 liblzma5 libmcrypt4 libmemcached11 libmemcachedutil2 libncurses5 libnettle6 libnghttp2-14 libp11-kit0 libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.0.2 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5 libtinfo5 libunistring0 libxml2 libxslt1.1 zlib1g
RUN bitnami-pkg unpack apache-2.4.37-21 --checksum b930db2471cbcdf2639c647794e724972cfcaba777ba0b922ddfc604a79c23fa
RUN bitnami-pkg unpack php-7.1.25-20 --checksum b4350f7370f196def8ff56462d7efb4961c15f97a705b96211006a16cec02cac
RUN bitnami-pkg unpack mysql-client-10.1.37-20 --checksum 414e98c1024187f1f0300eb3571f3d5ae54cdb36f3f08430be634714700bd1d9
RUN bitnami-pkg unpack libphp-7.1.25-21 --checksum c55887490c4242caaf4a7a9abefefaff71b5413cec6965b1e08a2795e4aff167
RUN bitnami-pkg unpack matomo-3.7.0-20 --checksum 9f3c4fa1ca33753eb75e6370f4723b41c128df26f0b8f6e518f5a37e462ab0f8
RUN mkdir -p /opt/bitnami/apache/tmp && chmod g+rwX /opt/bitnami/apache/tmp
RUN ln -sf /dev/stdout /opt/bitnami/apache/logs/access_log
RUN ln -sf /dev/stderr /opt/bitnami/apache/logs/error_log

# default ENV values
ENV ALLOW_EMPTY_PASSWORD="no" \
    APACHE_HTTPS_PORT_NUMBER="443" \
    APACHE_HTTP_PORT_NUMBER="80" \
    BITNAMI_APP_NAME="matomo" \
    BITNAMI_IMAGE_VERSION="3.7.0-debian-9-r38" \
    MARIADB_HOST="mariadb" \
    MARIADB_PORT_NUMBER="3306" \
    MARIADB_ROOT_PASSWORD="" \
    MARIADB_ROOT_USER="root" \
    MATOMO_DATABASE_NAME="bitnami_matomo" \
    MATOMO_DATABASE_PASSWORD="" \
    MATOMO_DATABASE_USER="bn_matomo" \
    MATOMO_EMAIL="user@example.com" \
    MATOMO_HOST="0.0.0.0" \
    MATOMO_PASSWORD="bitnami" \
    MATOMO_USERNAME="User" \
    MATOMO_WEBSITE_HOST="https://example.org" \
    MATOMO_WEBSITE_NAME="example" \
    MYSQL_CLIENT_CREATE_DATABASE_NAME="" \
    MYSQL_CLIENT_CREATE_DATABASE_PASSWORD="" \
    MYSQL_CLIENT_CREATE_DATABASE_PRIVILEGES="ALL" \
    MYSQL_CLIENT_CREATE_DATABASE_USER="" \
    PATH="/opt/bitnami/apache/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/mysql/bin:$PATH" \
    SMTP_HOST="" \
    SMTP_PASSWORD="" \
    SMTP_PORT="" \
    SMTP_PROTOCOL="" \
    SMTP_USER=""

# Commented out since ports will be exposed in kubernetes
#EXPOSE 80 443

RUN ["chmod", "+x", "app-entrypoint.sh"]

# Copy the plugins into the bitnami matomo folder
COPY plugins/GCToolsCore opt/bitnami/matomo/plugins/GCToolsCore/
COPY plugins/GCToolsTheme opt/bitnami/matomo/plugins/GCToolsTheme/

#RUN ls opt/bitnami/matomo/plugins/GCToolsTheme

ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "httpd", "-f", "/bitnami/apache/conf/httpd.conf", "-DFOREGROUND" ]