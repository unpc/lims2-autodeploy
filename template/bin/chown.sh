#!/bin/sh

mkdir -p /home/disk && chown -R www-data:www-data /home/disk

for p in ${DOCKER_LIMS2_DIR} ; do
	[ -e "$p" ] || mkdir -p "$p"
	chown -R www-data:www-data "$p"
done

# 将 Git 需要进行配置的的 Pub Key 打入到对应的容器内
mkdir -p "/root/.ssh/"

RSA_DIR="/root/.ssh/id_rsa"
RSA_PUB_DIR="/root/.ssh/id_rsa.pub"

[ -e "$RSA_DIR" ] || touch "$RSA_DIR"

cat <<EOF > $RSA_DIR
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA4UBxRgwlTWv+VNv9JSI+JtsCKiuv6xcdnOL3vmzKsMKqJfHT
cKQXNdg6KFeGoNmRAZchHhvkzgDhBuumW4DikmP4AAnMh6c+RZLRBd/aRNisqqqt
Kz2uuLJbxLy8ZSUR+oF/x9IKKVX4BGVTzZ9Sr551CKHUWkCvzAgurgiLcqVIJHcz
WH4A/jvqFbrPaioSmfm8T2+Mf1yv7UHH/PLzTBe56CaCcYwyvOB0CMJ0sffJo5DA
x9LigUV93b8WpDtTieqGE+Nnaks3H9v5Ox+daP4M3uZklpcNnewCGvTEu4LdhvDe
e80XLoMAuxXtKWS9DOjNUXrclntlDhn/OU1sAwIDAQABAoIBAQCiXxvITLUPDEv3
y+S9QePfinwS/g7/vlgAYbQIts+df5W7aIjsZ7y7ebTio8VOaccXiGO9Gopi3UtY
+8GdsFijAiEhle6z0qEW8fBu9aCXhEFjfUj7JKmwRhHUzeBYYNKG65a66fOdPHVe
ZdR1IuYt5mGi6VT0AjE3OKa9mTc8WgIir8x87ieOl3c3f2RljbRibRtYSts93KsA
UIUpf7pl23+oSOzBkUVJZfqf1BuB1B9mCw5QD7XM7Vk6qXA8L1JBsxFgeL7NL0C8
pn5uqBcV/jGsf9LHeSWBEO7fC/dCaRX2Q1pFQNR4cntssxNvfpNT8PaeiQS8eLsB
0grQ0l/hAoGBAPmXNEXOLFJR2y3dESGTBubsov2YzHZEa/ZOP8lYxDUURDkcFspB
/6LAGvJ3pn9U9cfaQl3GnLSniFo/2Heut5tyKJntgENb4YI/c3hVpOLbVtxoivF0
5+MwrPK7AW0gp3noX2xIGC0WVFWhPm1ErPqlaPcB+BFU9lrAudETXZ3bAoGBAOcJ
PEy0BP3GRlMUF7zVtMx0krkBUcBm1X7t1XRA0RKHFWvcENG9Fz0NhRjMeYvsLWfg
rk9vuYX4J4Lsqp4xDI4RrmBEzvALx26xAf5cCtGgaAoHFo7Cz3fL92lfQ2N98JjC
v5y/edxVmFOwBMd8JMiJI2uKBrc9wwkNi89Sz0b5AoGAUOH1KKH1rv+j3asEQDMb
S35oG3KG39Swf/M/rIo9m03kBfXaVNUqeJ10nhq0NBNeStOqKiWQ5uJbx5NlHPPb
wF4wViGnLSz7WXAihV6LvpCCB49BZ5oRA4jkowyDG9A3NcReGAMNAp932QAV8OcO
f3NXHqTetQ8pfqNyFBUIg30CgYEApKXnTD6KxBQ2b+SE2jVuqLp3CdOP4E8o3VE/
ap76oHqWYIyvi9l3IzJsZPTrtjT1Uu9DKidUDs5/0gU5voz0BpdBLyg6VcX/Nbp9
0jjkGOp42pScldbtpdE9G+IhE1lgSm2XwmyOuuBhM1rgvQ2S5Tsee/gcuyAPy3bU
6UZ5o3kCgYEA0QYxlSgMwwx/J8Apo+Gnsbkd9uXklWe32wNuNwgs4EZA7OtzLgMI
/nHnkGLlsJdQIsmyLlY3qQMrigsrKbpOv6yMaiZaMty9XCXbLeho1qnaCWYgc2yp
rPa3gxH3EVJz+wOvtX1xgMmoXZsvgzGemTC4HOnjpOHRx2u6f1vmLo4=
-----END RSA PRIVATE KEY-----
EOF

[ -e "$RSA_PUB_DIR" ] || touch "$RSA_PUB_DIR"

cat <<EOF > $RSA_PUB_DIR
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhQHFGDCVNa/5U2/0lIj4m2wIqK6/rFx2c4ve+bMqwwqol8dNwpBc12DooV4ag2ZEBlyEeG+TOAOEG66ZbgOKSY/gACcyHpz5FktEF39pE2Kyqqq0rPa64slvEvLxlJRH6gX/H0gopVfgEZVPNn1KvnnUIodRaQK/MCC6uCItypUgkdzNYfgD+O+oVus9qKhKZ+bxPb4x/XK/tQcf88vNMF7noJoJxjDK84HQIwnSx98mjkMDH0uKBRX3dvxakO1OJ6oYT42dqSzcf2/k7H51o/gze5mSWlw2d7AIa9MS7gt2G8N57zRcugwC7Fe0pZL0M6M1RetyWe2UOGf85TWwD root
EOF

chmod 644 "$RSA_PUB_DIR"
chmod 600 "$RSA_DIR"
chmod 700 "/root/.ssh/"