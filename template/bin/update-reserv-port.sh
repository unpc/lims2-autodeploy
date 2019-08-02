#!/bin/sh

# 对reserv-server代码进行再次更新
cd $DOCKER_RESERV_SERVER_DIR
git remote set-url origin git@192.168.18.26:reserv-server.git
git config --global user.email "support@geneegroup.com"
git config --global user.name "support"
git stash --include-untracked
git pull origin develop

echo "\$config['io.address'] = 'http://192.168.18.26:${RESERV_PUB_PORT}';" >> $DOCKER_LIMS2_DIR/modules/calendars/config/calendar.php

config_file=$DOCKER_LIMS2_DIR/application/config/beanstalkd.php

[ ! -w $config_file ] || sed -i "s/172.17.42.1/127.0.0.1/g" $config_file

SERVER_CONFIG=$DOCKER_RESERV_SERVER_DIR/config/default.js

[ ! -w $SERVER_CONFIG ] || sed -i "s/172.17.42.1/127.0.0.1/g" $SERVER_CONFIG

cd $DOCKER_RESERV_SERVER_DIR
cp -r /lims2-servers/data/reserv-server/node_modules/ .

sed -i "s/bin\/index.js/index.js/g" /etc/supervisor/conf.d/reserv-server.conf

sed -i "s/var\/lib/usr\/share/g" $DOCKER_LIMS2_DIR/supervisor.partner.conf
sed -i "s/172.17.42.1/127.0.0.1/g" $DOCKER_LIMS2_DIR/modules/calendars/libraries/cli/partner.php
cd /etc/supervisor/conf.d/ && ln -s $DOCKER_LIMS2_DIR/supervisor.partner.conf supervisor.partner.conf 

sed -i "s/var\/lib/usr\/share/g" $DOCKER_LIMS2_DIR/supervisor.partnerV2.conf
sed -i "s/172.17.42.1/127.0.0.1/g" $DOCKER_LIMS2_DIR/modules/calendars/libraries/cli/partnerV2.php
cd /etc/supervisor/conf.d/ && ln -s $DOCKER_LIMS2_DIR/supervisor.partnerV2.conf supervisor.partnerV2.conf
