#!/bin/bash

if [ $# -ne 3 ]; then
	echo "Too few or too many parameters"
	exit 4
elif [ ! -d $1 ]; then
	echo "The database does not exist"
	exit 3
elif [ -f $1/$2 ]; then
	echo "The table already exists"
	exit 5
else 
	./p.sh $1
	touch $1/$2
	echo $3>$1/$2
	echo "Table created"
	./v.sh $1
	exit 0
	
fi 
