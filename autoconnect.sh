#!/bin/bash

getNowIP() {
	tempString=$(./connect -u 1500012956 -p cppshidi1)
	tempString=${tempString#*IP}
	tempString=${tempString%C*}
	length=`expr ${#tempString} - 3`
	if [ $length == 47 ]
	then
		tempString="FULL"
	elif [ $length == 108 ]
	then
		tempString="ERROR"
	else
		tempString=${tempString:2:$length}
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

nowIP=$(getNowIP) 
echo $nowIP

case $nowIP in
	"FULL")
		./connect -u 1500012956 -p cppshidi1 -c >> /dev/null
		nowIP=$(getNowIP)
		;;
	"ERROR")
		continue
		;;
esac
echo $nowIP
		
if [ $oldIP != $nowIP ]
then
	echo $nowIP > ipaddr.txt
	syncGit
fi
sleep 5m
done




