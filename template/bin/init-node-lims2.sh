#!/bin/sh

logdir=$DOCKER_NODE_LIMS2_LOG_DIR
[ -e "$logdir" ] || mkdir -p "$logdir"
chown -R genee:admin "$logdir"
NOTIFICATION_CONFIG=$DOCKER_LIMS2_DIR/sites/$SITE_ID/labs/$LAB_ID/config/notification.php
if [ ! -e "$NOTIFICATION_CONFIG" ]; then
	printf "<?php\n\n" > "$NOTIFICATION_CONFIG"
fi
echo "\$config['server'] = ['addr' => 'http://localhost:8041','salt' => 'senomar'];" >> "$NOTIFICATION_CONFIG"
MESSAGE_CONFIG=$DOCKER_LIMS2_DIR/sites/$SITE_ID/labs/$LAB_ID/config/messages.php
if [ ! -e "$MESSAGE_CONFIG" ]; then
	printf "<?php\n\n" > "$MESSAGE_CONFIG"
fi
echo "\$config['server'] = ['addr' => 'http://localhost:8041','salt' => 'senomar'];" >> "$MESSAGE_CONFIG"