#!/bin/bash

dir=$(/usr/bin/dirname $0)

if [ ! -d /etc/nlplay ];then
    mkdir /etc/nlplay
fi

cp -aRrf ${dir}/bin/nlplay /usr/bin/
cp -aRrf ${dir}/bin/nlplayrun /usr/bin/
cp -aRrf ${dir}/libs/* /usr/local/lib/

cp -aRrf ${dir}/etc/simsun.ttc /etc/nlplay/
cp -aRrf ${dir}/etc/00-nlplay.conf /etc/ld.so.conf.d/
ldconfig

echo "/usr/bin/nlplay" > /etc/nlplay/library.file
echo "/usr/bin/nlplayrun" >> /etc/nlplay/library.file
for lib in `ls ${dir}/libs/`;do
    echo "/usr/local/lib/$lib" >> /etc/nlplay/library.file
done

echo "/etc/nlplay/simsun.ttc" >> /etc/nlplay/library.file
echo "/etc/ld.so.conf.d/00-nlplay.conf" >> /etc/nlplay/library.file

systemctl disable display-manager
# ln -s /lib/systemd/system/lightdm.service /etc/systemd/system/display-manager.service

echo "Successful installation -> reboot -> /usr/bin/nlplay"
