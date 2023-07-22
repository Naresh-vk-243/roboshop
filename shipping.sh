Red="\e[30m"
End="\e[0m"

echo "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/shipping.zip /etc/systemd/system/shipping.service
cp -f shipping.service /etc/systemd/system/shipping.service

echo "${Red} <<<<<<<<<<<<<< installing maven >>>>>>>>>>>>>>${End}"
yum install maven -y

echo "${Red} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop

echo "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip


echo "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar


echo "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user
systemctl restart user


echo "${Red} <<<<<<<<<<<<<< installing mysql >>>>>>>>>>>>>>${End}"
yum install mysql -y


echo "${Red} <<<<<<<<<<<<<< checking mysql connection >>>>>>>>>>>>>>${End}"
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 </app/schema/shipping.sql