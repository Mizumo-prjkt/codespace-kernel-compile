#!/bin/bash

if [ ! $(/usr/bin/id -u) == 0 ]; then
    echo "You need Root first"
    exit 1
fi


function package_man() {
    echo "deb http://security.ubuntu.com/ubuntu focal-security main universe" > /etc/apt/sources.list.d/ubuntu-focal-sources.list # for libncurses5
    apt update
    apt upgrade -y
    apt install software-properties-common
    add-apt-repository ppa:deadsnakes/ppa # we add deadsnakes to get us python2
    apt update # again
    apt install aria2 libncurses5 git python-is-python3 python2 python3 wget curl libc6-dev tar -y
    apt install cpio default-jdk git-core gnupg flex bison gperf build-essential zip curl aria2 libc6-dev libncurses5-dev x11proto-core-dev libx11-dev libreadline6-dev libgl1-mesa-glx libgl1-mesa-dev python3 make sudo gcc g++ bc grep tofrodos python3-markdown libxml2-utils xsltproc zlib1g-dev -y
    echo "Done installing dependencies"
}

read -p "The script will try to Install Necessary tools for the Android Kernel Compiling sessions, press 'Y' or 'y' for yes and 'N' or 'n' for no...: " ANS
case $ANS in
    [Yy]*)
        package_man
        exit
        ;;
    [Nn]*)
        echo "Aborted"
        exit
        ;;
    *)
        echo "$ANS is not a valid response"
        ./pre_setup.sh # lazy doing while true;do
        ;;
esac


