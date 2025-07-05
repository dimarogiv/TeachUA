#!/bin/sh

find /srv/html -type f -exec sed -i "s/global_ip_address/$IP_ADDRESS/g" {} \;
