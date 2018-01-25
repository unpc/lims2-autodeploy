#!/bin/sh

REGEXP="s|\(\$config\['root'\]=.*\)://\(genee.*@[^/]*\)/|\1://genee:${GENEE_PASSWORD:-83719730}@mysql/|"

CONFIG_FILE_FMT="${DOCKER_LIMS2_DIR}/%s/config/database.php"

sed -i $REGEXP "$(printf ${CONFIG_FILE_FMT} application)"

LAB_CONFIG="$(printf ${CONFIG_FILE_FMT} sites/${SITE_ID}/labs/${LAB_ID})"
[ ! -w $LAB_CONFIG ] || sed -i $REGEXP $LAB_CONFIG

DATABASE_CONFIG_FILE_FMT=$DOCKER_LIMS2_DIR/sites/$SITE_ID/labs/$LAB_ID/config/database.php
if [ ! -e "$DATABASE_CONFIG_FILE_FMT" ]; then
	printf "<?php\n\n" > "$DATABASE_CONFIG_FILE_FMT"
fi
echo "\$config['root'] = 'mysql://genee:83719730@mysql:3306/%database';\n" >> "$DATABASE_CONFIG_FILE_FMT"
echo "\$config['@sphinx.url'] = 'mysql://sphinx:9306';\n" >> "$DATABASE_CONFIG_FILE_FMT"

GLOBALS_FILE=$DOCKER_LIMS2_DIR/public/globals.php
if [ -e "$GLOBALS_FILE" ]; then
	sed -i "s/172.17.42.1/127.0.0.1/g" $GLOBALS_FILE
fi
