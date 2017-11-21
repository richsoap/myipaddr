#!/bin/bash

cd ~/.mycmd/myipaddr/

while true
do
read oldIP < ./ipaddr.txt
nowIP=getNowIP()
case $nowIP in
	"FULL")
		echo "close all"
		nowIP=getNowIP()
		;;
	"ERROR")
		continue
		;;
esac
		
if [ $oldIP != $nowIP ]
then
	echo $nowIP > ipaddr.txt
	syncGit()
fi
sleep 5m
done

syncGit() {
	pushdate=$(date)
	git commit -m "${pushdate}"
	git push origin master
}

getNowIP() {
	tempString=$(./connect -u 1500012956 -p cppshidi1)
	tempString=${tempString#*IP}
	tempString=${tempString%C*}
	length=`expr ${#tempString} - 2`
	if [ $length == 20 ]
	then
		tempString="FULL"
	elif [ $length == 25 ]
	then
		tempString="ERROR"
	else
		tempString=${tempString:2:$length}
	fi
	return $tempString
}
