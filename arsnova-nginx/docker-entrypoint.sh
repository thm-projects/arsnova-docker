#!/bin/sh
if [ -z "$1" ]; then
  printf "Testing upstream connection"
  for i in `seq 1 10`; do
    printf .
    curl -o /dev/null -s -I -f "http://webapp:8080/api/"
    if [ $? -eq 0 ]; then
      echo " OK."
      break;
    elif [ $i -ge 10 ]; then
      echo " FAILED."
      exit 1;
    fi
    sleep 10;
  done
  exec nginx -g "daemon off;"
fi
exec "$@";
