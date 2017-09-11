#!/bin/bash

cd ~/.mycmd/myipaddr/


ip addr show > ipaddr.txt
git add .
pushdate=$(date)
git commit -m $pushdate
git push origin master
