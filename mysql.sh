Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo INput Password Missing
  exit 1
fi

component=mysql
source commonFuncs.sh

copy_and_remove_Repo_files

echo -e "${Red} <<<<<<<<<<<<<< disableing previous mysql  >>>>>>>>>>>>>>${End}"
yum module disable mysql -y &>>${log}

echo -e "${Red} <<<<<<<<<<<<<< installing new sql as per repoo file >>>>>>>>>>>>>>${End}"
yum install mysql-community-server -y &>>${log}

starting_enabling_without_daemon

echo -e "${Red} <<<<<<<<<<<<<< setting root password  >>>>>>>>>>>>>>${End}"
mysql_secure_installation --set-root-pass ${mysql_root_password}

