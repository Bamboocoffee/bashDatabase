#!/bin/bash

if [ $# -ne 3 ]; then
        echo "Too few or too many parameters"
        exit 4
elif [ ! -d $1 ]; then
        echo "The database does not exist"
        exit 3
elif [ !  -f $1/$2 ]; then
        echo "The table does not exists"
        exit 6
else
	x=`head -n1 $1/$2 | grep -o "," | wc -l`
	y=`echo $3 | grep -o "," | wc -l`
	
	if [ $x -ne $y ]; then
		echo "Sorry, the number of columns in the tuple does not match schema"
		exit 7
	else
		./p.sh $1/$2
		echo $3>>$1/$2
        	echo "Okay, tuple inserted"
		./v.sh $1/$2
		exit 0
	fi
fi
