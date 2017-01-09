#!/bin/bash

#usage="Usage: dir_diff.sh [days]"
#if [!"$1"]
#then
#	echo$usage
#	exit1
#fi

days=35
now=$(date +%s)
DIR=<hdfs location>
hadoop fs -ls $DIR | grep "^d" | while read f; do
	dir_date=`echo $f | awk '{print $6}'`
	difference=$(( ( $now - $(date -d "$dir_date" +%s) ) / (24 * 60 * 60 ) ))
	if [ $difference -gt $days ]; 
	then
		hadoop fs -ls `echo $f| awk '{ print $8 }'`;
	fi
done

