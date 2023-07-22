RED='\e[31m'
RESET='\e[0m'

echo -e "${RED}>>>>>>>>>>>>> Installing nodejs <<<<<<<<<<${RESET}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash      v
yum install nodejs -y


echo -e "${RED}>>>>>>>>>>>>> adding roboshop user <<<<<<<<<<${RESET}"
useradd roboshop


echo -e "${RED}>>>>>>>>>>>>> removing and copying repo files and service files <<<<<<<<<<${RESET}"
rm -rf /etc/systemd/system/catalogue.service /etc/yum.repos.d/mongo.repo /tmp/catalogue.zip /app
cp -f catalogue.service /etc/systemd/system/catalogue.service
cp -f mongo.repo /etc/yum.repos.d/mongo.repo


echo -e "${RED}>>>>>>>>>>>>> creating app dir <<<<<<<<<<${RESET}"
mkdir /app



echo -e "${RED}>>>>>>>>>>>>> downloading catalogue code <<<<<<<<<<${RESET}"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app



echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
unzip /tmp/catalogue.zip
cd /app
npm install


echo -e "${RED}>>>>>>>>>>>>> restaring catalogue <<<<<<<<<<${RESET}"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue


echo -e "${RED}>>>>>>>>>>>>> Installing monogdb <<<<<<<<<<${RESET}"
yum install mongodb-org-shell -y


echo -e "${RED}>>>>>>>>>>>>> connecting to monodb <<<<<<<<<<${RESET}"
mongo --host  172.31.88.57 </app/schema/catalogue.js