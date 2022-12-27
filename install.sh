#!/bin/sh

command -v docker-compose &> /dev/null
if [ $? -ne 0 ]
then
  sudo curl -L https://github.com/docker/compose/releases/download/2.14.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
  sudo chmod +x /usr/bin/docker-compose
fi

mkdir www
cd www
wget -O ./discuz.zip https://gitee.com/Discuz/DiscuzX/attach_files/1278673/download
unzip ./discuz.zip -d _tmp
rm ./discuz.zip
mv _tmp/upload/* .
rm -rf _tmp

chmod -R 777 install
chmod -R 777 uc_server/install
chmod -R 777 data
chmod -R 777 config
chmod -R 777 uc_client/data
chmod -R 777 uc_server/data

cd ../docker
docker-compose up -d