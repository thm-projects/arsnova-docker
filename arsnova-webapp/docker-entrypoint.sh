#!/bin/sh
# Override config values from environment specified by the user
gawk '{
      match($0, /^(# ?)?([a-z0-9._-]+)( *= *)(.*)$/, a);
      if (RLENGTH != -1) {
        param = "ARSNOVA_" toupper(gensub(/[.-]/, "_", "g", a[2]));
        if ( param in ENVIRON) {
          out = a[2] a[3] ENVIRON[param];
        } else {
          out = $0;
        }
      } else {
        out = $0;
      }
      print out;
    }' </etc/arsnova/arsnova.properties >/tmp/arsnova.properties
/bin/mv /tmp/arsnova.properties /etc/arsnova/arsnova.properties

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
  cd /opt/arsnova/setuptool
  python /opt/arsnova/setuptool/tool.py
fi

# Compatibility with old configurations
if [ ! -z "$ROOT_URL" ]; then
  ARSNOVA_ROOT_URL=$ROOT_URL
fi

export CATALINA_HOME=/usr/share/tomcat8
export CATALINA_BASE=/var/lib/tomcat8
$CATALINA_HOME/bin/catalina.sh "$@"
