Red="\e[30m"
End="\e[0m"

echo "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/user.zip /etc/systemd/system/user.service /etc/yum.repos.d/mongo.repo
cp -f user.service /etc/systemd/system/user.service
cp -f mongo.repo /etc/yum.repos.d/mongo.repo

echo "${Red} <<<<<<<<<<<<<< installing nodejs >>>>>>>>>>>>>>${End}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y


echo "${Red} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop

echo "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip


echo "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
npm install


echo "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user
systemctl start user


echo "${Red} <<<<<<<<<<<<<< installing mongodb >>>>>>>>>>>>>>${End}"
yum install mongodb-org-shell -y


echo "${Red} <<<<<<<<<<<<<< checking mongodb connection >>>>>>>>>>>>>>${End}"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js