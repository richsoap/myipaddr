#!/bin/bash

cd ~/.mycmd/myipaddr/
# test


ip addr show > ipaddr.txt
git add .
pushdate=$(date)
git commit -m "${pushdate}"
git push origin master
