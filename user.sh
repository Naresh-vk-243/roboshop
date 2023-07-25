Red='\e[30m'
End='\e[0m'

echo -e "${Red}} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/user.zip /etc/systemd/system/user.service /etc/yum.repos.d/mongo.repo
cp -f user.service /etc/systemd/system/user.service
cp -f mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "${Red}} <<<<<<<<<<<<<< installing nodejs >>>>>>>>>>>>>>${End}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y


echo -e "${Red}} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop

echo -e "${Red}} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip


echo -e "${Red}} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
npm install


echo -e "${Red}} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo -e "${Red}} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user
systemctl start user


echo -e "${Red}} <<<<<<<<<<<<<< installing mongodb >>>>>>>>>>>>>>${End}"
yum install mongodb-org-shell -y


echo -e "${Red}} <<<<<<<<<<<<<< checking mongodb connection >>>>>>>>>>>>>>${End}"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js