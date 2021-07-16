#!/bin/bash

regex="\"uuid\":\s+\"\S+\""
regex2=":\s+\"\S+\""
regex3="[^\":\s]+"

dstPath="$HOME/.local/share/gnome-shell/extensions/"
mkdir -p $dstPath

tempDir="~shell-extensions/"
mkdir -p $tempDir

unzip -oqq shell-extensions.zip -d $tempDir

for f in $tempDir*.zip
do
	fileName=$(echo $f)
	metaData=$(unzip -c $fileName metadata.json)
	uuid=$(echo $(echo $(echo $metaData | grep -o -P $regex) | grep -o -P $regex) | grep -o -P $regex3)
	mkdir -p $dstPath$uuid
	unzip -oqq $f -d $dstPath$uuid
done

rm -r $tempDir
