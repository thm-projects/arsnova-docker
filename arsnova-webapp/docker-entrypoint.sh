#!/bin/sh
cd /arsnova-setuptool-"$ARSNOVA_SETUPTOOL_VERSION" && python tool.py
sed -i "s@^root-url=.*@root-url=$ROOT_URL@g" /etc/arsnova/arsnova.properties
export CATALINA_HOME=/usr/share/tomcat8
export CATALINA_BASE=/var/lib/tomcat8
$CATALINA_HOME/bin/catalina.sh $*
