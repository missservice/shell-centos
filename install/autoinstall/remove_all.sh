
#!/bin/bash
#Auto Remove Resin,Nginx,Java
#Author aiisen 2018-02-02
#Version 1.0

service resin-8080 stop
rm -rf /usr/local/resin
rm -rf /etc/init.d/resin*
rm -rf /www/8080
rm -rf /www/8081

service nginx stop
yum -y remove nginx
rm -rf /etc/nginx
rm -rf /etc/yum.repos.d/nginx.repo

yum -y remove jdk
