
#!/bin/bash
#Auto Install Resin,Nginx,Java
#Author aiisen 2018-02-02
#Version 1.0

sh install_jdk.sh
echo "sleep 10 seconds to install resin"
sleep 10
sh install_resin.sh
echo "sleep 10 seconds to install nginx"
sleep 10
sh install_nginx.sh
