
#!/bin/bash
#Auto Install Resin
#Author aiisen 2018-02-01
#Version 1.0

echo "#### check if resin is installed ####"
resinhome="/usr/local/resin"
if [ -d $resinhome ]; then
    echo "resin has installed in "$resinhome
    exit 0
fi

echo "#### download resin ####"
cd $resinhome
resinfile="resin-pro-3.1.13.tar.gz"
resinfilename="resin-pro-3.1.13"
if [ -e $resinfile ]; then
    echo $resinfile" is exist"
else
    echo $resinfile" is not exist"
    wget http://www.caucho.com/download/$resinfile
fi

echo "#### install resin ####"
tar zxvf $resinfile -C /usr/local
mv /usr/local/$resinfilename /usr/local/resin
rm -rf /usr/local/resin/webapps/resin-doc.war

echo "#### config resin ####"
installconffile="installconf.tar.gz"
if [ -e $installconffile ]; then
    echo $installconffile" is exist"
else
    echo $installconffile" is not exist"
    wget http://aiisen.qiniudn.com/$installconffile
    tar zxvf $installconffile
fi

echo "copy resin file to /usr/local/resin/conf and /etc/init.d "
cp installconf/resin-8080.conf /usr/local/resin/conf
cp installconf/resin-8081.conf /usr/local/resin/conf
cp installconf/resin-8080 /etc/init.d
cp installconf/resin-8081 /etc/init.d
chmod +x /etc/init.d/resin-8080
chmod +x /etc/init.d/resin-8081
mkdir -p /www/8080
mkdir -p /www/8081

touch /www/8080/index.html
echo "=8080=" > /www/8080/index.html

echo "restart resin"
service resin-8080 restart
chkconfig resin-8080 on

echo "sleep 10 seconds to start resin"
sleep 10

curl localhost:8080

echo "Please change the jvm params in /usr/local/resin/conf/resin-8080.conf"
