Red="\e[30m"
End="\e[0m"

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /etc/yum.repos.d/mysql.repo


echo -e "${Red} <<<<<<<<<<<<<< disableing previous mysql  >>>>>>>>>>>>>>${End}"
yum module disable mysql -y


echo -e "${Red} <<<<<<<<<<<<<< installing new sql as per repoo file >>>>>>>>>>>>>>${End}"
yum install mysql-community-server -y


echo -e "${Red} <<<<<<<<<<<<<< enabling and starting  >>>>>>>>>>>>>>${End}"
systemctl enable mysqld
systemctl restart mysqld


echo -e "${Red} <<<<<<<<<<<<<< setting root password  >>>>>>>>>>>>>>${End}"
mysql_secure_installation --set-root-pass RoboShop@1


echo -e "${Red} <<<<<<<<<<<<<< verifying sql is connected or not  >>>>>>>>>>>>>>${End}"
mysql -uroot -pRoboShop@1


