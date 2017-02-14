#!/bin/bash
#Function:Extract img urls from a page and download those imgs
#Date 2017-02-14
if [ $# -ne 3 ];
then
	echo 'Usage $0 URL -d DIRECTORY'
	exit -1 
fi

#while [ -n "$1" ];
while (("$#"));
do
	case $1 in 
		-d) shift; directory=$1;shift;;
		 *) url=${url:-$1};shift;;
	 esac
done
echo "url is:$url"
echo "directory is :$directory"
mkdir -p $directory
filename=/tmp/$$.list
#baseurl=$(echo $url | egrep -o "https?://[a-z1-9.]+")
baseurl=`echo $url | egrep -o "https?://[a-z1-9.]+"`
echo "baseurl is $baseurl"
echo Downloading $url
curl -s $url | egrep -o '<img src=[^>]*>' | sed 's/<img src=\"\([^"]*\).*/\1/g' | grep -v http > $filename
sed -i "s|^/|$baseurl/|" $filename

cd $directory

while read filename;
do
	echo Downloading $filename
	curl -s -O "$filename" --silent
done < /tmp/$$.list

