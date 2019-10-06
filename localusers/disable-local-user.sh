#!/bin/bash

#Script to disable,delete, or optionally archive

ARCHIVE_DIR="/archive"
#Make the script be executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
	echo "Please run with sudo or root privileges"
	exit 1
fi

#Display the usage and exit
usage(){
echo "Usage : ${0} [-dra] USERNAME [USERNAME]...">&2
echo "Disable the local linux account">&2
echo "-d Deletes the account instead of deleting them">&2
echo "-r Removes the home directory associated with the account">&2
echo "-a Create an archive of the home directory associated with the account">&2
exit 1
}

#Parse the options
while getopts dra OPTION
do 	
	case ${OPTION} in
		d)DELETE_USER="true" ;;
		r)REMOVE_OPTION="-r";;
		a)ARCHIVE="true" ;;
		?) usage ;;
	esac
done

#Remove the options while leaving the remaining arguments
shift "$(( OPTIND-1 ))"

#If the user doesnt supply at least one argument, give them help
if [[ "${#}" -lt 1 ]]
then
	usage
fi
 
#Loop through all the usernames supplied as arguments
for USERNAME in "${@}"
do
	echo "Processing user : ${USERNAME}"


	#Make sure the UID of the account is at least 1000
	USERID=$(id -u ${USERNAME})
	if [[ "${USERID}" -lt 1000 ]]
	then
		echo "Refusing to remove the ${USERNAME} account with UID ${USERID}".>&2
	exit 1
	fi
	#Create an archive if requested to do so
	if [[ "${ARCHIVE}"="true" ]]
	then
		if [[ ! -d "${ARCHIVE_DIR}" ]]
		then 
			echo "Creating ${ARCHIVE_DIR} directory"
			mkdir -p ${ARCHIVE_DIR}
			if [[ "${?}" -ne 0 ]]
			then 
				echo "Could not create archive directory">&2
				exit 1
			fi
		fi


	#Archive the users home directory and move it into the ARCHIVE_DIR 
	HOME_DIR="/home/${USERNAME}"
	ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
	if [[ -d "${HOME_DIR}" ]]
	then
		echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
		tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
		if [[ "${?}" -ne 0 ]]
		then
			echo "Couldnt archive the file" >&2
			exit 1
		fi
		else
			echo "${HOME_DIR} does not exists or is not in a directory">&2
			exit 1
	fi
	fi
	if [[ "${DELETE_USER}"="true" ]]
	then
		#Delete the user
	userdel "${USER}"

	#Check to see if the userdel was successful
	if [[ "${?}" -ne 0 ]]
	then 
		echo "${USER} was not deleted"
		exit 1
	fi
	echo "The account ${USERNAME} was deleted"
	else
		chage -E 0 ${USERNAME}

	#We dont want to tell the user that when the account was deleted
	#check to see if the chage was succeded
	if [[ "${?}" -ne 0 ]]
	then
        	echo "The accont ${USERNAME} was not disabled">&2
        exit 1
	fi
	echo "The account ${USERNAME} was disabled"
	fi
done

exit 0
