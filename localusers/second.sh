#!/bin/bash

#Display the uid , username 
#Check if the user is root user or not

#Display the uid
echo "Your UID is ${UID}"



#Display the username
USER_NAME=$(whoami)
echo "Your user name is ${USER_NAME}"

#Check if the user is root user or not
if [[ "${UID}" -eq 0 ]]
then
	echo "You are root"
else
	echo "You are not root"
fi
