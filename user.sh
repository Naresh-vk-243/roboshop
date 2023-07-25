Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

echo -e "${Red}} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/user.zip /etc/systemd/system/user.service /etc/yum.repos.d/mongo.repo &>>${log}
cp -f user.service /etc/systemd/system/user.service &>>${log}
cp -f mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "${Red}} <<<<<<<<<<<<<< installing nodejs >>>>>>>>>>>>>>${End}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
yum install nodejs -y &>>${log}


echo -e "${Red}} <<<<<<<<<<<<<< addig roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop &>>${log}

echo -e "${Red}} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}" &>>${log}
mkdir /app &>>${log}
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log}
cd /app &>>${log}
unzip /tmp/user.zip &>>${log}


echo -e "${Red}} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app &>>${log}
npm install &>>${log}


echo -e "${Red}} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload &>>${log}


echo -e "${Red}} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user &>>${log}
systemctl start user &>>${log}


echo -e "${Red}} <<<<<<<<<<<<<< installing mongodb >>>>>>>>>>>>>>${End}"
yum install mongodb-org-shell -y &>>${log}


echo -e "${Red}} <<<<<<<<<<<<<< checking mongodb connection >>>>>>>>>>>>>>${End}"
mongo --host 172.31.88.57 </app/schema/user.js &>>${log}