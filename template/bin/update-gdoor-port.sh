#!/bin/sh

echo "\$config['dc_gdoor']['port'] = ${GDOOR_PUB_PORT}; // gdoor 门禁端口" >> $DOCKER_LIMS2_DIR/modules/entrance/config/device.php


# 对Gdoor代码进行再次更新
cd $DOCKER_GDOOR_SERVER_DIR 
git remote set-url origin git@192.168.0.26:gdoor-server.git
git stash --include-untracked
git pull origin develop
git stash pop

GDOOR_CONFIG_FILE=$DOCKER_GDOOR_SERVER_DIR/config/default.js
if [ -e "$GDOOR_CONFIG_FILE" ]; then
	sed -i "s/172.17.42.1/127.0.0.1/g" $GDOOR_CONFIG_FILE
fi

if [ -e "$GDOOR_CONFIG_FILE" ]; then
	sed -i "s/2950/${GDOOR_API_PUB_PORT}/g" $GDOOR_CONFIG_FILE
fi

supervisorctl restart gdoor-server
