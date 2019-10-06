#!/bin/bash

#function definition
display(){

local MESSAGE="Hello,inside"
echo "${MESSAGE}"

}

#function call
display
echo "Outside the function ${MESSAGE}"

