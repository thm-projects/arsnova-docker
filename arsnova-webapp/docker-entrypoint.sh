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
  python /opt/arsnova/setuptool/tool.py
fi

# Compatibility with old configurations
if [ ! -z "$ROOT_URL" ]; then
  ARSNOVA_ROOT_URL=$ROOT_URL
fi

export CATALINA_HOME=/usr/share/tomcat8
export CATALINA_BASE=/var/lib/tomcat8
exec $CATALINA_HOME/bin/catalina.sh "$@"
