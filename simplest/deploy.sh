#!/bin/sh

set -e
set -x

sudo cp helloworld_0_simplest.service /etc/systemd/system/


sudo mkdir -p /var/helloworld_0_simplest
sudo chown -R www-data:www-data /var/helloworld_0_simplest

sudo -u www-data rsync -ra \
  --exclude .git/ \
  --filter=':- .gitignore' \
  . /var/helloworld_0_simplest


# Reload and restart services
sudo systemctl daemon-reload
sudo service helloworld_0_simplest reload || sudo service helloworld_0_simplest start
