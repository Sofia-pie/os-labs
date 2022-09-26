#!/bin/bash
echo -n 'Enter username:'
read username
FILE=hello.txt
if [ "$username" = "$USER" ];
then
	if  [ -f "$FILE" ];
	then
		echo "Hello, $USER"
	else
		echo "Hello, Sofiia Piesnia, Ipz 2.1"
	fi
else
	echo "Wrong name"
fi
