#!/bin/bash

# remove pid file if it exists
if [ -e "/var/run/openvpnas.pid" ]; then
  rm -f "/var/run/openvpnas.pid" &>/dev/null
fi

# run openvpnas 
/usr/local/openvpn_as/scripts/openvpnas --logfile=- --pidfile=/var/run/openvpnas.pid --nodaemon
