#!/bin/sh

# Fail on a single failed command
set -eo pipefail

DIR=${DEPLOY_DIR:-/deployments}
echo "Checking *.war in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.war; do
     file=$(basename $i)
     echo "Linking $i --> /opt/jetty/webapps/$file"
     ln -s $i /opt/jetty/webapps/$file
  done
fi

export JAVA_OPTIONS="$JAVA_OPTIONS $(/deployments/run-java.sh options) -Djava.security.egd=file:/dev/./urandom"
/usr/bin/env bash /opt/jetty/bin/jetty.sh run
