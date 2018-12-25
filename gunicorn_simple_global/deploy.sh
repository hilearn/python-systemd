#!/bin/sh

set -e
set -x

project_name=helloworld_2_gunicorn_simple_global
destination=/var/$project_name

sudo cp $project_name.service /etc/systemd/system/


sudo mkdir -p $destination
sudo chown -R www-data:www-data $destination

sudo -u www-data rsync -ra \
  --exclude .git/ \
  --filter=':- .gitignore' \
  . \
  $destination


# Reload and restart services
sudo systemctl daemon-reload
sudo service $project_name reload || sudo service $project_name start
