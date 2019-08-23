#!/bin/sh

set -e
set -x

project_name=helloworld_1_nginx_simple
destination=/var/$project_name

sudo mkdir -p $destination
sudo chown -R www-data:www-data $destination

sudo -u www-data rsync -ra \
  --exclude .git/ \
  --filter=':- .gitignore' \
  . \
  $destination


# Reload and restart services
sudo cp $project_name.service /etc/systemd/system/
sudo cp $project_name.socket /etc/systemd/system/

sudo systemctl daemon-reload
sudo service $project_name reload || sudo service $project_name start


# Copy nginx config and enable it
site_name=8001_$project_name
sudo cp nginx_localhost.conf /etc/nginx/sites-available/$site_name
sudo rm -f /etc/nginx/sites-enabled/$site_name
sudo ln -s /etc/nginx/sites-available/$site_name /etc/nginx/sites-enabled/$site_name
sudo service nginx restart

