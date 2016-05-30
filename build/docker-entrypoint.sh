#!/bin/bash

# remove pid file if it exists
if [ -e "/var/run/openvpnas.pid" ]; then
  rm -f "/var/run/openvpnas.pid" &>/dev/null
fi

# set the openvpn admin password
# the default openvpn password is openvpn
if [ -z "$OPENVPN_PASSWORD" ]; then 
  OPENVPN_PASSWORD="openvpn"
fi
echo "openvpn:$OPENVPN_PASSWORD" | chpasswd

# run openvpnas 
/usr/local/openvpn_as/scripts/openvpnas --logfile=- --pidfile=/var/run/openvpnas.pid --nodaemon
