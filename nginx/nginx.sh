#!/bin/sh
set -ex

# create TLS certificate
openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=${HOSTNAME}" -addext "subjectAltName=DNS:${HOSTNAME},DNS:localhost" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;

# replace hostname in nginx config files with real host name
envsubst '${HOSTNAME}' < /etc/nginx/template.conf > /etc/nginx/conf.d/default.conf

# start nginx
nginx -g 'daemon off;'
