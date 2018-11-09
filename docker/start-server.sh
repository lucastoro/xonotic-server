#!/bin/bash

[ -f /opt/Xonotic/shared/server.cfg ] || {
  echo '/opt/Xonotic/shared/server.cfg is missing'
  echo 'start the container with -v [path containing server.cfg]:/opt/Xonotic/shared'
  exit 1
}

[ -e /opt/Xonotic/data/server.cfg ] || {
  cd /opt/Xonotic/data
  ln -s ../shared/server.cfg .
}

cd /opt/Xonotic/server
lighttpd -f /etc/lighttpd/lighttpd.conf
./server_linux.sh
