#!/bin/bash

#Display the UID and username of the user executing this script
#Display if the user is vagrant user or not

#Display the UID
echo "Your UID is ${UID}"

#Only if the UID is 1000
UID_TEST='1000'
if [[ "${UID_TEST}" -ne "${UID}" ]]
then 
	echo "Your UID doesnt match with ${UID_TEST}"
	exit 1
fi

#Display the username
USER_NAME=$(id -un)

#Test if the command is successfull
if [[ "${?}" -ne 0 ]]
then
	echo "Your command didnt execute successfully"
	exit 1
fi
echo "Your username is ${USER_NAME}"

#Comparison of the string
TEST_USERNAME="vagrant"
if [[ "${USER_NAME}" = "${TEST_USERNAME}" ]]
then 
	echo "Your username matches with ${TEST_USERNAME}"
fi


#Test for != for string 
if [[ "${USER_NAME}" != "${TEST_USERNAME}" ]]
then 	
	echo "Your username doesnt match ${TEST_USERNAME}"
	exit 1
fi

exit 0

