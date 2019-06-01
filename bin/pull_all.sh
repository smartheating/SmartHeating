#!/bin/bash

# This script goes through all repositories and pulls them. 
# Requirement 1: Working directory is SmartHeating/bin
# Requirement 2: All repositories are on the same hierarchical level as SmartHeating (in the file system)
cd ../..
wd=$(pwd)
dirs=$(ls)
x=$(cd -)
for file in $dirs
do
    path=$wd/$file/.git
    # make sure that path points to a repo
    if [[ -d $path ]]
    then
        echo 🔵 $path
        git --git-dir=$path pull
    fi
done