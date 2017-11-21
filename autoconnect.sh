#!/bin/bash

getNowIP() {
	tempString=$(./connect -u 1500012956 -p cppshidi1)
	tempString=${tempString#*IP}
	tempString=${tempString%C*}
	length=`expr ${#tempString} - 2`
	if [ $length == 50 ]
	then
		tempString="FULL"
	elif [ $length == 111 ]
	then
		tempString="ERROR"
	else
		tempString=${tempString:2:$length}
	fi
	return $tempString
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

getNowIP
nowIP=$?

case $nowIP in
	"FULL")
		./connect -u 1500012956 -p cppshidi1 -c
		getNowIP
		nowIP=$?
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
sleep 5m
done




