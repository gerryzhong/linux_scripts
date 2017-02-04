#!/bin/bash
#Function:count the frequency of each word in a file
#Date: 2017-02-04 15:48
if [ $# -ne 1 ];
then
	echo "Usage:$0 filename"
	exit -1
fi

filename=$1
grep -E -o "\b[[:alpha:]]+\b" $filename |
awk '{count[$0]++;}
END{ printf("%-14s%s\n","Word","Count");
for(word in count){
	printf("%-14s%s\n",word,count[word]);
}
}'
