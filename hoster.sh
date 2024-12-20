#!/bin/bash

hosterup () {
  docker run -d --rm --name hoster -v /var/run/docker.sock:/tmp/docker.sock -v /etc/hosts:/tmp/hosts  dvdarias/docker-hoster
}

hosterdown () {
  docker stop hoster
}

case $1 in
up) hosterup ;;
down) hosterdown ;;
*) echo "invalid option '$1'" ;;
esac