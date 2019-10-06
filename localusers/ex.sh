#!/bin/bash

#only root user must execute this file
if [[ "${UID}" -ne 0 ]]
then 
	echo "Not a root user"
	exit 1
fi


#get the user name
read -p "Enter the username : " USER_NAME

#get the real name ie comment
read -p "Enter your real name : " COMMENT

#get the password
read -p "Enter the password :" PASSWORD

#create the user with his read password
useradd -m "${USER_NAME}" -c "${COMMENT}"

#check if useradd command is successful
if [[ "${?}" -ne 0 ]]
then
        echo "useradd command didnt work successfully."
        exit 1
fi

#set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

#check if the passwd command is successfull
if [[ "${?}" -ne 0 ]]
then 
	echo "passwd command didnt work successfully"
	exit 1
fi

#force password change for 1st time login
passwd -e ${USER_NAME}

#Display username,password,host where it was created
echo "Username: " ${USER_NAME}
echo "Password: " ${PASSWORD}
echo "Host is created in location: " ${HOSTNAME}

exit 0


