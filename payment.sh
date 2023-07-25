Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/payment.zip /etc/systemd/system/payment.service &>>${log}
cp -f payment.service /etc/systemd/system/payment.service &>>${log}

echo -e "${Red} <<<<<<<<<<<<<< installing python >>>>>>>>>>>>>>${End}"
yum install python36 gcc python3-devel -y &>>${log}
 &>>${log}
echo -e "${Red} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop &>>${log}

echo -e "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>${log}
cd /app &>>${log}
unzip /tmp/payment.zip &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app &>>${log}
pip3.6 install -r requirements.txt &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload &>>${log}


echo -e "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable payment &>>${log}
systemctl restart payment &>>${log}
