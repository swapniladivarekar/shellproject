#set -x
#Spring boot example project
#Author: Swapnil Adivarekar
#Date: 07-07-2025
function InstallPackage(){
        packagename=${1}
        apt-get install -y ${packagename}
        if [[ $? != 0 ]]
        then
                echo -e "\033[0;31mUnable to install ${packagename}"
                exit 1
                fi
}
function MavenTarget(){
        maveninp=${1}
        mvn ${maveninp}
        if [[ $? != 0 ]]
        then
                echo -e "\033[0;31mUnable to perform maven ${maveninp}"
                exit 1
                fi
}
#check is user is a root user
if [[ $UID != 0 ]]
then
        echo -e "\033[0;31mUser is not a root user"
        exit 1
fi
#updating a repository
apt-get update > /dev/null
if [[ $? != 0 ]]
then
        echo -e "\033[0;31mRepository not update successfully"
        exit 1
fi
##installing maven and tomcat
InstallPackage maven
MavenTarget test
MavenTarget package
InstallPackage tomcat9

cp -rf /projects/spring-boot-war-example/target /var/lib/tomcat9/webapps/app.war
