#!/bin/bash
# shortcuts for Apache-Tomcat Server

tcdir='/home/glados/Downloads/apache-tomcat-8.5.9'
date=$(date "+%Y-%m-%d")

case $1 in
	start) 
		re=$(sudo bash ${tcdir}/bin/startup.sh)
		if [ $? -eq 0 ]; then
			echo -e "\033[34m[INFO]\033[0m Tomcat Home: ${tcdir}"
			echo -e "\033[34m[INFO]\033[0m Tomcat started."
		else
			echo -e "\033[31m[ERROR]\033[0m Tomcat carshed."
		fi	
		sudo tail -f ${tcdir}/logs/catalina.out;;
	shut)
		re=$(bash ${tcdir}/bin/shutdown.sh);
		if [ $? -eq 0 ]; then
			echo -e "\033[34m[INFO]\033[0m Tomcat shut."
		else
			echo -e "\033[31m[ERROR]\033[0m Tomcat crashed."
		fi;;
	restart)
		flag=$(ps | grep java)
		if [[ ${flag} =~ "java" ]]; then
			re1=$(bash ${tcdir}/bin/shutdown.sh)
			re2=$(sudo bash ${tcdir}/bin/startup.sh)
			echo -e "\033[34m[INFO]\033[0m Tomcat Restarted."
			echo -e "\033[34m[INFO]\033[0m Tomcat Log:"
			sudo tail -f ${tcdir}/logs/localhost.${date}.log | grep localhost | cut -d" " -f2,6,7,8,9,10,11,12,13,14
		else
			echo -e "\033[31m[ERROR]\033[0m Tomcat not started yet."
		fi;;
	log)
		clear
		sudo tail -n 10 ${tcdir}/logs/localhost.${date}.log | grep localhost | cut -d" " -f2,6,7,8,9,10,11,12,13,14;;
	--help|help|-h)
		echo -e "	Apache Tomcat Server start/shut/monitor shortcuts."
		echo -e "	Usage: tomcat [OPTION...]"
		echo -e "	Options:"
		echo -e "	    start    Start the server."
		echo -e "	    shut     Shut the present server down."
		echo -e "       restart  Restart the server."
		echo -e "       log      See the localhost log."
		echo -e "	If you ever want to change the server installation path,"
		echo -e "	  come rewrite this script file."
esac

exit 0

