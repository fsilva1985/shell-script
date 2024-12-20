#!/bin/bash

redisup () {
	docker run -d --rm --network="host" --name redisinsight \
		-v /home/felipe.miranda/redisinsight:/db \
		redislabs/redisinsight
}

redisdown () {
	docker stop redisinsight
}

case $1 in
up) redisup ;;
down) redisdown ;;
*) echo "invalid option '$1'" ;;
esac
