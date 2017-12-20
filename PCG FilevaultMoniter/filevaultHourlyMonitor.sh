#! /bin/ksh
flag=False;
num=0;

while   read   data;   do
        if [[ "$data" =~ "filevault folder status" ]];then
		flag=True;
	fi
	if [[ "$data" =~ "rows selected" ]];then
		if [[ "$flag" == "True" ]];then
			flag=False;
                	var1=`echo "$data"|awk -F ' ' '{print $1}'`
                	num=$var1
		fi
        fi
done   <   /oratools/monitor/logs/dbHourlyMonitor_`date +%Y-%m-%d`.log


echo $num

if [[ "$num" -lt 3 ]];then
	`java -jar sendEmail.jar`
	echo "send email"
fi
echo "`date +%Y-%m-%d`"
