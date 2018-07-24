
#!/bin/bash
#Auto Install Nginx
#Author aiisen 2018-02-02
#Version 1.0

echo "#### check if nginx is installed ####"
nginxhome="/etc/nginx"
if [ -d $nginxhome ]; then
    echo "nginx has installed in "$nginxhome
    exit 0
fi

echo "#### config nginx yum.repos for centos6 ####"

os="`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`"
echo "$os"
if [ "$os" = "6" ]; then
    echo "os is centos 6"
    rpm -Uvh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
else
    echo "os is centos 7"
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
fi

#cat >> /etc/yum.repos.d/nginx.repo  << EOF
#[nginx]
#name=nginx repo
#baseurl=http://nginx.org/packages/centos/6/\$basearch/
#gpgcheck=0
#enabled=1
#EOF
#yum makecache

echo "#### install nginx ####"
yum -y install nginx
#if centos 7 install failed use rpm install and dependencies
#yum -y install pcre*
#yum -y install zlib*
#yum -y install openssl openssl-devel
#rpm -Uvh http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-1.12.0-1.el7.ngx.x86_64.rpm

echo "#### config nginx ####"
if [ -e $nginxhome ]; then
    echo $nginxhome" is exist, installed successful."
else
    echo $nginxhome" is not exist, installed failed."
	exit 0
fi

installconffile="installconf.tar.gz"
if [ -e $installconffile ]; then
    echo $installconffile" is exist"
else
    echo $installconffile" is not exist"
    wget http://aiisen.qiniudn.com/$installconffile
    tar zxvf $installconffile
fi

echo "copy resin file to /etc/nginx/"
rm -rf /etc/nginx/conf.d/default.conf
\cp -f installconf/nginx.conf /etc/nginx/
cp installconf/nginx-8080.conf /etc/nginx/conf.d

echo "restart nginx"
service nginx restart
chkconfig nginx on

echo "sleep 2 seconds to start nginx"
sleep 2

curl localhost
