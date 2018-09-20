#!/bin/bash
## 
 # pass-git-helper is a simple shell script to store git credentials in
 # a pass storage (https://www.passwordstore.org).
 # Copyright (c) 2018 Lucas Treffenstädt.
 # 
 # This program is free software: you can redistribute it and/or modify  
 # it under the terms of the GNU General Public License as published by  
 # the Free Software Foundation, version 3.
 #
 # This program is distributed in the hope that it will be useful, but 
 # WITHOUT ANY WARRANTY; without even the implied warranty of 
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
 # General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License 
 # along with this program. If not, see <http://www.gnu.org/licenses/>.
 ##

#Store a new credential
if [ "$1" == "store" ]
then
	while read line
	do
		var=$(echo $line | cut -d "=" -f 1)
		declare "$var=$(echo $line | cut -d "=" -f 2)"
	done
	#defer for 5 seconds to avoid a conflict if this is used from pass itself
	(sleep 5;echo -e "$password\nlogin: $username" | pass insert -m git-$host &> /dev/null)&
#Read credentials
elif [ "$1" == "get" ]
then
	query=""
	while read line
	do
		query=$query$line"\n"
		var=$(echo $line | cut -d "=" -f 1)
		declare "$var=$(echo $line | cut -d "=" -f 2)"
	done
	pw=$(pass git-$host 2> /dev/null)
	if [ $? == 0 ]
	then
		pw=$(echo $pw | cut -d " " -f 1)
		echo -e $query"password=$pw\n"
	fi
#Delete credentials
elif [ "$1" == "erase" ]
then
	while read line
	do
		var=$(echo $line | cut -d "=" -f 1)
		declare "$var=$(echo $line | cut -d "=" -f 2)"
	done
	#defer for 5 seconds to avoid a conflict if this is used from pass itself
	(sleep 5; pass rm -f git-$host &> /dev/null)&
fi
