#!/bin/bash

# Disable Strict Host checking for non interactive git clones

#mkdir -p -m 0700 /root/.ssh
#echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
#
#if [[ "$GIT_USE_SSH" == "1" ]] ; then
#  echo -e "Host *\n\tUser ${GIT_USERNAME}\n\n" >> /root/.ssh/config
#fi
#
#if [ ! -z "$SSH_KEY" ]; then
# echo $SSH_KEY > /root/.ssh/id_rsa.base64
# base64 -d /root/.ssh/id_rsa.base64 > /root/.ssh/id_rsa
# chmod 600 /root/.ssh/id_rsa
#fi

# Set custom webroot
if [ ! -z "$WEBROOT" ]; then
 sed -i "s#root /data/httpd;#root ${WEBROOT};#g" /etc/nginx/sites-available/default.conf
else
 webroot=/data/httpd
fi

# Setup git variables
#if [ ! -z "$GIT_EMAIL" ]; then
# git config --global user.email "$GIT_EMAIL"
#fi
#if [ ! -z "$GIT_NAME" ]; then
# git config --global user.name "$GIT_NAME"
# git config --global push.default simple
#fi

# Dont pull code down if the .git folder exists
#if [ ! -d "/data/httpd/.git" ]; then
# # Pull down code from git for our site!
# if [ ! -z "$GIT_REPO" ]; then
#   # Remove the test index file if you are pulling in a git repo
#   if [ ! -z ${REMOVE_FILES} ] && [ ${REMOVE_FILES} == 0 ]; then
#     echo "skiping removal of files"
#   else
#     rm -Rf /data/httpd/*
#   fi
#   GIT_COMMAND='git clone '
#   if [ ! -z "$GIT_BRANCH" ]; then
#     GIT_COMMAND=${GIT_COMMAND}" -b ${GIT_BRANCH}"
#   fi
#
#   if [ -z "$GIT_USERNAME" ] && [ -z "$GIT_PERSONAL_TOKEN" ]; then
#     GIT_COMMAND=${GIT_COMMAND}" ${GIT_REPO}"
#   else
#    if [[ "$GIT_USE_SSH" == "1" ]]; then
#      GIT_COMMAND=${GIT_COMMAND}" ${GIT_REPO}"
#    else
#      GIT_COMMAND=${GIT_COMMAND}" https://${GIT_USERNAME}:${GIT_PERSONAL_TOKEN}@${GIT_REPO}"
#    fi
#   fi
#   ${GIT_COMMAND} /data/httpd || exit 1
#   chown -Rf www.www /data/httpd
# fi
#fi

# Try auto install for composer
#if [ -f "/data/httpd/composer.lock" ]; then
#  composer install --no-dev --working-dir=/data/httpd
#fi

# Enable custom nginx config files if they exist
#if [ -f /data/httpd/conf/nginx/nginx-site.conf ]; then
#  cp /data/httpd/conf/nginx/nginx-site.conf /etc/nginx/conf.d/nginx-site.conf
#fi
#
#if [ -f /data/httpd/conf/nginx/nginx-site-ssl.conf ]; then
#  cp /data/httpd/conf/nginx/nginx-site-ssl.conf /etc/nginx/conf.d/nginx-site-ssl.conf
#fi
#
## Display PHP error's or not
#if [[ "$ERRORS" != "1" ]] ; then
# echo php_flag[display_errors] = off >> /usr/local/etc/php-fpm.conf
#else
# echo php_flag[display_errors] = on >> /usr/local/etc/php-fpm.conf
#fi
#
## Display Version Details or not
#if [[ "$HIDE_NGINX_HEADERS" == "0" ]] ; then
# sed -i "s/server_tokens off;/server_tokens on;/g" /etc/nginx/nginx.conf
#else
# sed -i "s/expose_php = On/expose_php = Off/g" /usr/local/etc/php-fpm.conf
#fi
#
## Pass real-ip to logs when behind ELB, etc
#if [[ "$REAL_IP_HEADER" == "1" ]] ; then
# sed -i "s/#real_ip_header X-Forwarded-For;/real_ip_header X-Forwarded-For;/" /etc/nginx/sites-available/default.conf
# sed -i "s/#set_real_ip_from/set_real_ip_from/" /etc/nginx/sites-available/default.conf
# if [ ! -z "$REAL_IP_FROM" ]; then
#  sed -i "s#172.16.0.0/12#$REAL_IP_FROM#" /etc/nginx/sites-available/default.conf
# fi
#fi
## Do the same for SSL sites
#if [ -f /etc/nginx/sites-available/default-ssl.conf ]; then
# if [[ "$REAL_IP_HEADER" == "1" ]] ; then
#  sed -i "s/#real_ip_header X-Forwarded-For;/real_ip_header X-Forwarded-For;/" /etc/nginx/sites-available/default-ssl.conf
#  sed -i "s/#set_real_ip_from/set_real_ip_from/" /etc/nginx/sites-available/default-ssl.conf
#  if [ ! -z "$REAL_IP_FROM" ]; then
#   sed -i "s#172.16.0.0/12#$REAL_IP_FROM#" /etc/nginx/sites-available/default-ssl.conf
#  fi
# fi
#fi
#
## Increase the memory_limit
#if [ ! -z "$PHP_MEM_LIMIT" ]; then
# sed -i "s/memory_limit = 128M/memory_limit = ${PHP_MEM_LIMIT}M/g" /usr/local/etc/php/conf.d/docker-vars.ini
#fi
#
## Increase the post_max_size
#if [ ! -z "$PHP_POST_MAX_SIZE" ]; then
# sed -i "s/post_max_size = 100M/post_max_size = ${PHP_POST_MAX_SIZE}M/g" /usr/local/etc/php/conf.d/docker-vars.ini
#fi
#
## Increase the upload_max_filesize
#if [ ! -z "$PHP_UPLOAD_MAX_FILESIZE" ]; then
# sed -i "s/upload_max_filesize = 100M/upload_max_filesize= ${PHP_UPLOAD_MAX_FILESIZE}M/g" /usr/local/etc/php/conf.d/docker-vars.ini
#fi

if [ ! -z "$PUID" ]; then
  if [ -z "$PGID" ]; then
    PGID=${PUID}
  fi
  deluser www
  addgroup -g ${PGID} www
  adduser -D -S -h /var/cache/www -s /sbin/nologin -G www -u ${PUID} www
else
  # Always chown webroot for better mounting
  chown -Rf www.www /data/httpd
  chown -Rf mysql.mysql /data/mysql
fi

# Run custom scripts
#if [[ "$RUN_SCRIPTS" == "1" ]] ; then
#  if [ -d "/data/httpd/scripts/" ]; then
#    # make scripts executable incase they aren't
#    chmod -Rf 750 /data/httpd/scripts/*
#    # run scripts in number order
#    for i in `ls /data/httpd/scripts/`; do /data/httpd/scripts/$i ; done
#  else
#    echo "Can't find script directory"
#  fi
#fi

#start mysql services
/usr/bin/mysqld_safe &

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf