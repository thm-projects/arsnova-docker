FROM openjdk:8-jre
LABEL maintainer "Daniel Gerhardt <code@z.dgerhardt.net>"

ENV ARSNOVA_BACKEND_VERSION 2.5.0
ENV ARSNOVA_MOBILE_VERSION 2.5.0
ENV ARSNOVA_SETUPTOOL_VERSION 2.5.0
ENV ARSNOVA_BACKEND_ARCHIVE arsnova-backend-$ARSNOVA_BACKEND_VERSION.war
ENV ARSNOVA_BACKEND_URL https://github.com/thm-projects/arsnova-backend/releases/download/v$ARSNOVA_BACKEND_VERSION/$ARSNOVA_BACKEND_ARCHIVE
ENV ARSNOVA_MOBILE_ARCHIVE arsnova-mobile-$ARSNOVA_MOBILE_VERSION.war
ENV ARSNOVA_MOBILE_URL https://github.com/thm-projects/arsnova-mobile/releases/download/v$ARSNOVA_MOBILE_VERSION/$ARSNOVA_MOBILE_ARCHIVE
ENV ARSNOVA_SETUPTOOL_ARCHIVE v$ARSNOVA_SETUPTOOL_VERSION.tar.gz
ENV ARSNOVA_SETUPTOOL_URL https://github.com/thm-projects/arsnova-setuptool/archive/$ARSNOVA_SETUPTOOL_ARCHIVE
ENV ARSNOVA_CONFIG_URL https://raw.githubusercontent.com/thm-projects/arsnova-backend/v$ARSNOVA_BACKEND_VERSION/src/main/resources/arsnova.properties.example

ARG TOMCAT_VALVE='<Valve\
 className="org.apache.catalina.valves.RemoteIpValve"\
 remoteIpHeader="x-forwarded-for"\
 protocolHeader="x-forwarded-proto" />'

# HTTP
EXPOSE 8080
# WebSocket
EXPOSE 8090

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    gawk \
    libservlet3.1-java \
    nginx \
    python \
    tomcat8 \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN \
  curl -SLO "$ARSNOVA_BACKEND_URL" && \
  curl -SLO "$ARSNOVA_MOBILE_URL" && \
  mv "$ARSNOVA_BACKEND_ARCHIVE" /var/lib/tomcat8/webapps/api.war && \
  mv "$ARSNOVA_MOBILE_ARCHIVE" /var/lib/tomcat8/webapps/mobile.war

RUN \
  curl -SLO "$ARSNOVA_CONFIG_URL" && \
  mkdir /etc/arsnova && \
  sed \
    # Remove escaped line breaks
    -e ':a;N;$!ba;s/\\\n *//g' \
    arsnova.properties.example | \
    # Adjust defaults for Docker vnet
    sed \
    -e 's/^\(couchdb.host *= *\).*/\1couchdb/g' \
    -e 's/^\(socketio.bind-address *= *\).*/\10.0.0.0/g' \
    -e '/^#socketio.proxy-path *=/s/^#//g' \
    -e 's/^#\(session.guest-session.cleanup-days *= *\).*/\10/g' | \
    # Add environment variable support to properies file
    gawk '{ \
      match($0, /^(# ?)?([a-z0-9._-]+)( *= *)(.*)$/, a); \
      if (RLENGTH != -1) { \
        b = gensub(/[.-]/, "_", "g", a[2]); \
        defaultVal = ""; \
        if (!a[1]) defaultVal = a[4]; \
        out = a[2] a[3] "${ARSNOVA_" toupper(b) ":" defaultVal "}"; \
      } else { \
        out = $0; \
      } \
      print out; \
    }' \
    > /etc/arsnova/arsnova.properties && \
  rm arsnova.properties.example && \
  sed -i "s#</Host>#  $TOMCAT_VALVE\n\n      </Host>#g" /etc/tomcat8/server.xml

RUN \
  curl -SLO "$ARSNOVA_SETUPTOOL_URL" && \
  tar xzf "$ARSNOVA_SETUPTOOL_ARCHIVE" && \
  rm -rf "$ARSNOVA_SETUPTOOL_ARCHIVE"

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["run"]
