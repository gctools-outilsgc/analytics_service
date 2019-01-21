# analytics_service

A custom implementation of Matomo designed to be run on a kubernetes cluster built ontop of the [bitnami matomo docker image](https://github.com/bitnami/bitnami-docker-matomo).

## Plugins

A custom theme and custom plugin are being copy into the docker image and enabled. See the plugins folders for the plugin source files and `config/app-entrypoint.sh` for the console commands that enable the plugins upon image startup. 

All configuration is happening via console commands at image startup in order to possibly support scaling.

## Setup

#### quick setup

To run the docker container with the database simply run:

`sudo docker-compose up`

#### dev setup

If you would like to make changes to the plugins and/or rebuild the container with these changes follow the following steps:


To install matomo run:

```
sudo apt-get install php7.0 php7.0-curl php7.0-gd php7.0-cli mysql-server php7.0-mysql php-xml php7.0-mbstring

git clone https://github.com/matomo-org/matomo matomo
cd matomo
git submodule update --init
composer install
```

To copy over and activate custom plugins run:

```
# Go back to the repository's root directory
cd ..

# Copy over the plugin files to matomo's plugin directory
cp -R plugins/GCToolsCore matomo/plugins/
cp -R plugins/GCToolsTheme matomo/plugins/

# Activate the plugins using the matomo console
# 
cd matomo
./console plugin:activate GCToolsCore
./console plugin:activate GCToolsTheme

# make localhost:8000 a trusted host for testing purposes
./console config:set --section="General" --key="trusted_hosts[]" --value="0.0.0.0:8000"
```

Enable development mode if you would like to generate fake visitors or look at the component showcase page:

`./console development:enable`

Spin up the database:

```
cd ..
sudo docker-compose up mariadb
```

Run matomo:

```
cd matomo
php -S 0.0.0.0:8000
```

Lastly, follow the instalation instructions found at http://localhost:8000/. See the docker-compose file for required credentials.

## Rebuilding the production docker image

`sudo docker build -t username:tag .`