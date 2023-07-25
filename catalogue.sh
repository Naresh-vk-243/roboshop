RED='\e[31m'
RESET='\e[0m'

echo -e "${RED}>>>>>>>>>>>>> Installing nodejs <<<<<<<<<<${RESET}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash&>>${log}
yum install nodejs -y &>>${log}


echo -e "${RED}>>>>>>>>>>>>> adding roboshop user <<<<<<<<<<${RESET}"
useradd roboshop &>>${log}


echo -e "${RED}>>>>>>>>>>>>> removing and copying repo files and service files <<<<<<<<<<${RESET}"
rm -rf /etc/systemd/system/catalogue.service /etc/yum.repos.d/mongo.repo /tmp/catalogue.zip /app&>>${log}
cp -f catalogue.service /etc/systemd/system/catalogue.service&>>${log}
cp -f mongo.repo /etc/yum.repos.d/mongo.repo&>>${log}


echo -e "${RED}>>>>>>>>>>>>> creating app dir <<<<<<<<<<${RESET}"
mkdir /app&>>${log}



echo -e "${RED}>>>>>>>>>>>>> downloading catalogue code <<<<<<<<<<${RESET}"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip&>>${log}
cd /app&>>${log}



echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
unzip /tmp/catalogue.zip&>>${log}
cd /app&>>${log}
npm install&>>${log}


echo -e "${RED}>>>>>>>>>>>>> restaring catalogue <<<<<<<<<<${RESET}"
systemctl daemon-reload&>>${log}
systemctl enable catalogue&>>${log}
systemctl restart catalogue&>>${log}


echo -e "${RED}>>>>>>>>>>>>> Installing monogdb <<<<<<<<<<${RESET}"
yum install mongodb-org-shell -y&>>${log}


echo -e "${RED}>>>>>>>>>>>>> connecting to monodb <<<<<<<<<<${RESET}"
mongo --host  172.31.88.57 </app/schema/catalogue.js&>>${log}