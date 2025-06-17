#!/bin/sh

rm -rf /axonserver/data/* /axonserver/events/* /axonserver/log/* /axonserver/config/*
exec java -jar axonserver.jar \
  --server.hostname=axonserver \
  --axoniq.axonserver.standalone=true \
  --axoniq.axonserver.devmode.enabled=true