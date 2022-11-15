#/bin/bash

logger=`tail $rabbitmq-path`

logger_length=`echo $logger | awk {'print NF'}`

for ((i=1; i<=$logger_length; i++))
do
    if [ `echo $logger | awk -v i=$i {'print $i'}` = "[error]" ]
    then
        echo "error detected"
        curl -X POST -H "Authorization: Bearer LINEToken" -F "message=Error detected on rabbit@`hostname`" https://notify-api.line.me/api/notify
        break
    else
        echo "Nothing detected" > /dev/null 2>&1
    fi
done
