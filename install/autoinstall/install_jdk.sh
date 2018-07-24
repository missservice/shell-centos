
#!/bin/bash
#Auto Install JDK
#Author aiisen 2018-02-01
#Version 1.0

echo "#### check if jdk is installed ####"
if [[ ! -z $(rpm -qa | grep jdk | grep -v grep) ]]; then
    echo "jdk has installed. version is:"
    rpm -qa | grep jdk | grep -v grep
    exit 0
else
    echo "start installing jdk..."
fi

echo "#### download jdk ####"
jdkfile="jdk-7u80-linux-x64.rpm"
if [ -e $jdkfile ]; then
    echo $jdkfile" is exist"
else
    echo $jdkfile" is not exist"
    wget https://mirror.its.sfu.ca/mirror/CentOS-Third-Party/NSG/common/x86_64/$jdkfile
fi

echo "#### install jdk ####"
rpm -ivh $jdkfile

echo "#### config java home ####"
cat >> /etc/profile  << EOF

########### jdk config begin ###########
JAVA_HOME=/usr/java/default
M2_HOME=/usr/local/apache-maven 
CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
PATH=\$PATH:\$JAVA_HOME/bin:\$M2_HOME/bin
export JAVA_HOME CLASSPATH PATH
########### jdk config end ###########
EOF

echo "#### refresh profile ####"
source /etc/profile

echo "#### verify jdk is installed successfully ####"
java -version
echo $JAVA_HOME
