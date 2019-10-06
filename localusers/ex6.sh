#!/bin/bash

#Parsing the log files

LOG_FILE="${1}"
#Make sure a file was supplied as an argument
if [[ ! -e "${LOG_FILE}" ]]
then 
	echo "Couldnt open ${LOG_FILE} file"
	exit 1
fi

#Display CSV header
echo "Count , IP ,Location"

#Loop through the list of failed attempts and corresponding IP address
grep "Failed" "${LOG_FILE}" |awk '{print $(NF-3)}' | sort |uniq -c | sort -nr | while read COUNT IP
do
	#If the number of failed attempts greater than the limit display the count IP,and location
	if [[ "${COUNT}" -gt "${LIMIT}" ]]
	then
		LOCATION=$(geoiplookup ${IP})
		echo "${COUNT} ${IP} ${LOCATION}"
	fi
done
exit 0
