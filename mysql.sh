Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /etc/yum.repos.d/mysql.repo &>>${log}
cp -f mysql.repo /etc/yum.repos.d/mysql.repo &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< disableing previous mysql  >>>>>>>>>>>>>>${End}"
yum module disable mysql -y &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< installing new sql as per repoo file >>>>>>>>>>>>>>${End}"
yum install mysql-community-server -y &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< enabling and starting  >>>>>>>>>>>>>>${End}"
systemctl enable mysqld &>>${log}
systemctl restart mysqld &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< setting root password  >>>>>>>>>>>>>>${End}"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< verifying sql is connected or not  >>>>>>>>>>>>>>${End}"
mysql -uroot -pRoboShop@1 &>>${log}


