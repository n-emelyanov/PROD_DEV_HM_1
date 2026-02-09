#!/bin/bash
file=$1
touch $file

git add ${file}

git commit -m "${file} added"