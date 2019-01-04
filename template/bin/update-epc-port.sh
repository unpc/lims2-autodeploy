#!/bin/sh

# 对epc代码进行再次更新
cd $DOCKER_EPC_SERVER_DIR 
git remote set-url origin git@192.168.0.26:epc-server.git
git stash --include-untracked
git pull origin develop
git stash pop

EPC_CONFIG_FILE=$DOCKER_EPC_SERVER_DIR/config/default.js
if [ -e "$EPC_CONFIG_FILE" ]; then
	sed -i "s/172.17.42.1/127.0.0.1/g" $EPC_CONFIG_FILE
fi

if [ -e "$EPC_CONFIG_FILE" ]; then
	sed -i "s/3061/3061, host:'http:\/\/127.0.0.1'/g" $EPC_CONFIG_FILE
fi

supervisorctl restart epc-server
