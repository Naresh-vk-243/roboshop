Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/shipping.zip /etc/systemd/system/shipping.service &>>${log}
cp -f shipping.service /etc/systemd/system/shipping.service &>>${log}

echo -e "${Red} <<<<<<<<<<<<<< installing maven >>>>>>>>>>>>>>${End}"
yum install maven -y &>>${log}

echo -e "${Red} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop &>>${log}

echo -e "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app &>>${log}
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>${log}
cd /app &>>${log}
unzip /tmp/shipping.zip &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app &>>${log}
mvn clean package &>>${log}
mv target/shipping-1.0.jar shipping.jar &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable shipping &>>${log}
systemctl restart shipping &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< installing mysql >>>>>>>>>>>>>>${End}"
yum install mysql -y &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< checking mysql connection >>>>>>>>>>>>>>${End}"
mysql -h mysql.nareshdevops.cloud -uroot -pRoboShop@1 </app/schema/shipping.sql &>>${log}