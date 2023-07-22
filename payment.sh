Red="\e[30m"
End="\e[0m"

echo "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/payment.zip /etc/systemd/system/payment.service
cp -f payment.service /etc/systemd/system/payment.service

echo "${Red} <<<<<<<<<<<<<< installing python >>>>>>>>>>>>>>${End}"
yum install python36 gcc python3-devel -y

echo "${Red} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop

echo "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip


echo "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
pip3.6 install -r requirements.txt


echo "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user
systemctl restart user
