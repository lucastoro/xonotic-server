#!/bin/bash

[ -f /opt/Xonotic/shared/server.cfg ] || {
  echo '/opt/Xonotic/shared/server.cfg is missing'
  echo 'start the container with -v [path containing server.cfg]:/opt/Xonotic/shared'
  exit 1
}

echo 'copying server.cfg...'
cp /opt/Xonotic/shared/server.cfg /opt/Xonotic/data/

[ -d /opt/Xonotic/shared/maps ] && {
  echo 'copying maps...'
  for file in /opt/Xonotic/shared/maps/*.pk3; do
    echo " - $(basename $file)"
    cp $file /opt/Xonotic/data
  done
}

cd /opt/Xonotic/server
echo 'starting http server...'
lighttpd -f /etc/lighttpd/lighttpd.conf
echo 'starting nginx server...'
./server_linux.sh >> /opt/Xonotic/shared/server.log
echo 'stopping the http server...'
kill $(pidof lighttpd)
echo 'shutting down'
