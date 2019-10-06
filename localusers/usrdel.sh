#!/bin/bash

#This is a script to delete a user

#Run only in sudo mode
if [[ "${UID}" -ne 0 ]]
then 
	echo "Please run in sudo or root mode"
	exit 1
fi

#1st argument is the user name
USER="${1}"

#delete the user
userdel ${USER}

#check if the userdel command has succeded
if [[ "${?}" -ne 0 ]]
then 
	echo "User was not deleted"
	exit 1
else
	echo "${USER} was deleted"
fi
