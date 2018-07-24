
#!/bin/bash
#Auto Install mysql 5.5
#Author aiisen 2018-02-02
#Version 1.0

echo "#### check if mysql is installed ####"
mysqlfile="/etc/init.d/mysqld"
if [ -d $mysqlfile ]; then
    echo "mysql has installed "
    exit 0
fi

rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi

yum --enablerepo=remi -y install mysql mysql-server

echo "#### config mysql ####"
installconffile="installconf.tar.gz"
if [ -e $installconffile ]; then
    echo $installconffile" is exist"
else
    echo $installconffile" is not exist"
    wget http://aiisen.qiniudn.com/$installconffile
    tar zxvf $installconffile
fi

\cp -f installconf/my.conf /etc/

service mysqld restart 

echo "#### 请替换密码后手工执行下面脚本 ####"
echo "mysqladmin -u root password moba"
echo "mysql -u root -p"
echo "grant all privileges on *.* to 'root'@'%' identified by 'moba' with grant option;"

