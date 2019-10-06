#!/bin/bash


#No space near equals sign
NAME1='Prajwal'
NAME2='Kushal'

#It does not work as it is single quotes
echo '${NAME}'

#it should be double quotes
echo "${NAME1}  ${NAME2}"



