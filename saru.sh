#!/bin/bash

# Script written by Peyton Blanscet, 2022

if [[ -d "$1" ]]; then
	cd $1
elif [ "$1" != "" ]; then
	echo "Invalid Argument, please pass a directory"
	exit 0
fi

echo "This script is operating in $PWD, and all files and subdirectories within this file will be collapsed to $PWD".
printf 'Do you want to continue? (y/n) '
read answer

if [ "$answer" != "${answer#[Yy]}" ]; then
	find -mindepth 2 -type f -print -exec bash -c 'if [ "$(dirname "$1")" != "." ]; then fp=$(dirname "$1");fn=$(basename "$fp");ofn=$(basename "${1%.*}");px="${1##*.}";mv "$1" "$fp"/"$fn"_"$ofn"."$px"; fi' sh "{}" \;
	find . -mindepth 2 -type f -print -exec mv --backup=numbered '{}' . \;
	find . -type d -empty -delete
else
	exit 1
fi
