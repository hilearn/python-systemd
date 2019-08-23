#!/bin/sh

set -e
set -x

project_name=helloworld_0_simplest


# Copy code to the destination directory where it will run
# The service will run with user www-data
destination=/var/$project_name

sudo mkdir -p $destination
sudo chown -R www-data:www-data $destination

sudo -u www-data rsync -ra \
  --exclude .git/ \
  --filter=':- .gitignore' \
  . \
  $destination


# Copy systemd files to the correct location.
sudo cp $project_name.service /etc/systemd/system/

# Reload systemctl
sudo systemctl daemon-reload
# Enable the service so it's there when the comuper restarts.
sudo systemctl enable $project_name.service

# restart services
sudo service $project_name reload || sudo service $project_name start
