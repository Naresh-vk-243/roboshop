Red="\e[30m"
End="\e[0m"

echo "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /etc/yum.repos.d/mysql.repo


echo "${Red} <<<<<<<<<<<<<< disableing previous mysql  >>>>>>>>>>>>>>${End}"
yum module disable mysql -y


echo "${Red} <<<<<<<<<<<<<< installing new sql as per repoo file >>>>>>>>>>>>>>${End}"
yum install mysql-community-server -y


echo "${Red} <<<<<<<<<<<<<< enabling and starting  >>>>>>>>>>>>>>${End}"
systemctl enable mysqld
systemctl restart mysqld


echo "${Red} <<<<<<<<<<<<<< setting root password  >>>>>>>>>>>>>>${End}"
mysql_secure_installation --set-root-pass RoboShop@1


echo "${Red} <<<<<<<<<<<<<< verifying sql is connected or not  >>>>>>>>>>>>>>${End}"
mysql -uroot -pRoboShop@1


