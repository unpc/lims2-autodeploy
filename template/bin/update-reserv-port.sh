#!/bin/sh

echo "\$config['io.address'] = 'http://rum.genee.cn:${RESERV_PUB_PORT}';" >> $DOCKER_LIMS2_DIR/modules/calendars/config/calendar.php

cli_file=$DOCKER_LIMS2_DIR/modules/eq_reserv/libraries/cli

[ ! -w $cli_file ] || sed -i "s/172.17.42.1/127.0.0.1/g" $cli_file/partner.php
[ ! -w $cli_file ] || sed -i "s/172.17.42.1/127.0.0.1/g" $cli_file/tube.php

config_file=$DOCKER_LIMS2_DIR/application/config/beanstalkd.php

[ ! -w $config_file ] || sed -i "s/172.17.42.1/127.0.0.1/g" $config_file



