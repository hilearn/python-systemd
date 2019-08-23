#!/bin/sh

set -e
set -x

project_name=8012_nginx_gunicorn_socket_pass


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


# Take care of systemd service that runs on a unix socket, not a computer port.
# Copy systemd files to the correct location.
sudo cp $project_name.service /etc/systemd/system/
sudo cp $project_name.socket /etc/systemd/system/
sudo cp $project_name.conf /etc/tmpfiles.d/

sudo systemctl stop $project_name.socket || true
sudo systemctl stop $project_name.service || true

# Reload and restart services
sudo systemctl daemon-reload

# Enable the socket
sudo systemctl enable $project_name.socket

# Start the socket 
sudo systemctl start $project_name.socket
# sudo service $project_name reload || sudo service $project_name start


# Use nginx to handle outside world communications.
# Copy nginx config and enable it
site_name=$project_name
sudo cp nginx_localhost.conf /etc/nginx/sites-available/$site_name
sudo ln -fs /etc/nginx/sites-available/$site_name /etc/nginx/sites-enabled/$site_name
sudo service nginx restart

