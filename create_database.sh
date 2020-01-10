#!/bin/bash

if [ $# -eq 0 ]; then
	echo "No arguments given"
	exit 1
elif [ -d $1 ]; then
	echo "The database already exists"
	exit 2
else 
	mkdir $1
	echo "Database created"	
	exit 0

fi
	
