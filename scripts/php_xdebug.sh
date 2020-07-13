#!/bin/bash
###!/bin/env bash

# Simple script to enable or disable the xdebug extension CentOS

# sed -i '1 a xdebug.remote_autostart=true' /etc/php.d/15-xdebug.ini
# sed -i '1 a xdebug.remote_mode=req' /etc/php.d/15-xdebug.ini
# sed -i '1 a xdebug.remote_handler=dbgp' /etc/php.d/15-xdebug.ini
# sed -i '1 a xdebug.remote_host=127.0.0.1' /etc/php.d/15-xdebug.ini
# sed -i '1 a xdebug.remote_port=9000' /etc/php.d/15-xdebug.ini

case $1 in
  on)
    [ -f /etc/php.d/15-xdebug.ini.deactivated ] && sudo mv /etc/php.d/15-xdebug.ini.deactivated /etc/php.d/15-xdebug.ini

    [ -f /etc/php.d/15-xdebug.ini ] && {
      sudo sed -i 's/^\( *;xdebug.remote_enable = 0 *\)[^ ]*\(.*\)*$/xdebug.remote_enable = 1\2/' /etc/php.d/15-xdebug.ini;
      sudo sed -i 's/^\( *;xdebug.remote_connect_back = 0 *\)[^ ]*\(.*\)*$/xdebug.remote_connect_back = 1\2/' /etc/php.d/15-xdebug.ini
    } || {
      sudo touch /etc/php.d/15-xdebug.ini; 
      sudo sh -c "echo xdebug.remote_enable=1 >> /etc/php.d/15-xdebug.ini";
      sudo sh -c "echo xdebug.remote_connect_back=1 >> /etc/php.d/15-xdebug.ini";
    }

    sudo systemctl restart php-fpm.service 
    sudo systemctl restart nginx.service
    echo "Xdebug is ON"
  ;;
  off)
    [ -f /etc/php.d/15-xdebug.ini ] && sudo mv /etc/php.d/15-xdebug.ini /etc/php.d/15-xdebug.ini.deactivated
    sudo systemctl restart php-fpm.service 
    sudo systemctl restart nginx.service
    echo "Xdebug is OFF"
  ;;
  *)
    if [ -f /etc/php/7.0/mods-available/xdebug.ini ]; then
      . ~/.dotfiles/scripts/helpers/php_xdebug.sh off
    else
      . ~/.dotfiles/scripts/helpers/php_xdebug.sh on
    fi
  ;;
esac
