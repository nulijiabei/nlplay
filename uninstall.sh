#!/bin/bash

if [ -e /etc/nlplay/library.file ];then
    for file in `cat /etc/nlplay/library.file`;do
        rm -f $file
    done
fi

echo "Successful uninstall"
