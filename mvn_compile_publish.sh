#!/bin/bash
# maven project compile and update to Tomcat server

tcpdir='/home/glados/Downloads/apache-tomcat-8.5.9/webapps'
project_name='etraining'
wkspace='/home/glados/Downloads/apache-tomcat-8.5.9/webapps/_etraining'

cd ${wkspace}/${project_name}
mvn clean | grep -iE "Deleting|Finished"
mvn compile war:war | grep -iE "Scanning|Building|Compiling|Packaging|Processing|Finished"
if [ $? -eq '0' ];
then
	echo -e "\033[34m[INFO]\033[0m Project compiled."
else
	echo -e "\033[31m[ERROR]\033[0m Project build error."
	exit 1
fi

sudo mv ${wkspace}/${project_name}/target/${project_name}.war ${tcdir}/${project_name}.war
if [ -f ${tcpdir}/${project_name}.war ];
then
	echo -e "\033[34m[INFO]\033[0m Project republished."
else
	echo -e "\033[31m[ERROR]\033[0m Project republish failed."
	exit 1
fi

exit 0

