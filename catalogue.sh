RED='\e[31m'
RESET='\e[0m'

echo -e "${RED}>>>>>>>>>>>>> Installing nodejs <<<<<<<<<<${RESET}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash      v
yum install nodejs -y


echo -e "${RED}>>>>>>>>>>>>> adding roboshop user <<<<<<<<<<${RESET}"
useradd roboshop


echo -e "${RED}>>>>>>>>>>>>> removing and copying repo files and service files <<<<<<<<<<${RESET}"
rm -rf /etc/systemd/system/catalogue.service /etc/yum.repos.d/mongo.repo
cp -f catalogue.service /etc/systemd/system/catalogue.service
cp -f mongo.repo /etc/yum.repos.d/mongo.repo
rm  -rf /tmp/catalogue.zip


echo -e "${RED}>>>>>>>>>>>>> creating app dir <<<<<<<<<<${RESET}"
mkdir /app



echo -e "${RED}>>>>>>>>>>>>> downloading catalogue code <<<<<<<<<<${RESET}"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app



echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
unzip /tmp/catalogue.zip
cd /app
npm install


echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue


echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
yum install mongodb-org-shell -y


echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
mongo --host  172.31.88.57 </app/schema/catalogue.js