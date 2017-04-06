#!/bin/sh
if [ "$1" = run ]; then
  printf "Testing database connection"
  for i in `seq 1 10`; do
    printf .
    curl -o /dev/null -s -I -f "http://couchdb:5984/"
    if [ $? -eq 0 ]; then
      echo " OK."
      break;
    elif [ $i -ge 10 ]; then
      echo " FAILED."
      exit 1;
    fi
    sleep 10;
  done
  cd /arsnova-setuptool-"$ARSNOVA_SETUPTOOL_VERSION" && python tool.py
  sed -i "s@^root-url=.*@root-url=$ROOT_URL@g" /etc/arsnova/arsnova.properties
fi
export CATALINA_HOME=/usr/share/tomcat8
export CATALINA_BASE=/var/lib/tomcat8
$CATALINA_HOME/bin/catalina.sh "$@"
