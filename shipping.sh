Red='\e[31m'
End='\e[0m'

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/shipping.zip /etc/systemd/system/shipping.service
cp -f shipping.service /etc/systemd/system/shipping.service

echo -e "${Red} <<<<<<<<<<<<<< installing maven >>>>>>>>>>>>>>${End}"
yum install maven -y

echo -e "${Red} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop

echo -e "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip


echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar


echo -e "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo -e "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable shipping
systemctl restart shipping


echo -e "${Red} <<<<<<<<<<<<<< installing mysql >>>>>>>>>>>>>>${End}"
yum install mysql -y


echo -e "${Red} <<<<<<<<<<<<<< checking mysql connection >>>>>>>>>>>>>>${End}"
mysql -h 172.31.87.23 -uroot -pRoboShop@1 </app/schema/shipping.sql