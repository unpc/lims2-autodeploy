#!/bin/sh

echo "\$config['dc_gdoor']['port'] = ${GDOOR_PUB_PORT}; // gdoor 门禁端口" >> $DOCKER_LIMS2_DIR/modules/entrance/config/device.php

GDOOR_CONFIG_FILE=$DOCKER_GDOOR_SERVER_DIR/config/default.js
if [ -e "$GDOOR_CONFIG_FILE" ]; then
	sed -i "s/172.17.42.1/127.0.0.1/g" $GDOOR_CONFIG_FILE
fi

if [ -e "$GDOOR_CONFIG_FILE" ]; then
	sed -i "s/2950/${GDOOR_API_PUB_PORT}/g" $GDOOR_CONFIG_FILE
fi

