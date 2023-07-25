RED='\e[31m'
RESET='\e[0m'
log=/tmp/roboshop.log

echo -e "${RED}>>>>>>>>>>>>> removing repo files <<<<<<<<<<${RESET}"
rm -rf /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "${RED}>>>>>>>>>>>>> copying new repo files <<<<<<<<<<${RESET}"
cp -f mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

echo -e "${RED}>>>>>>>>>>>>> Installing mongod <<<<<<<<<<${RESET}"
yum install mongodb-org -y &>>${log}

echo  "${RED} <<<<<<<<<<<<<< replacing the ip address to 0.0.0.0  >>>>>>>>>>>>>>${RESET}"
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf &>>${log}

echo -e "${RED}>>>>>>>>>>>>> enabling mongod <<<<<<<<<<${RESET}"
systemctl enable mongod &>>${log}
systemctl start mongod &>>${log}

echo -e "${RED}>>>>>>>>>>>>> restarting mongod <<<<<<<<<<${RESET}"
systemctl restart mongod &>>${log}