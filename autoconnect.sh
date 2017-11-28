#!/bin/bash

getNowIP() {
	tempString=$(./connect -u 1500012956 -p cppshidi1)
	tempString=${tempString#*IP}
	tempString=${tempString%%\;*}
	length=${#tempString}
	if [ $length == 50 ]
	then
		tempString="FULL"
	elif [ $length == 111 ]
	then
		tempString="ERROR"
	else
		tempString=${tempString:2}
	fi
	echo $tempString
}

syncGit() {
	pushdate=$(date)
	git add .
	git commit -m "${pushdate}"
	git push origin master
}


cd ~/.mycmd/myipaddr/

while true
do
read oldIP < ipaddr.txt
if [ ${#oldIP} == 0 ]
then
	oldIP="NULL"
fi


nowIP=$(getNowIP) 

case $nowIP in
	"FULL")
		./connect -u 1500012956 -p cppshidi1 -c >> /dev/null
		nowIP=$(getNowIP)
		;;
	"ERROR")
		continue
		;;
esac
		
if [ $oldIP != $nowIP ]
then
	echo $nowIP > ipaddr.txt
	syncGit
fi
sleep 3m
done




