RED='\e[31m'
RESET='\e[0m'


echo -e "${RED}>>>>>>>>>>>>> removing repo files <<<<<<<<<<${RESET}"
rm -rf /etc/yum.repos.d/mongo.repo

echo -e "${RED}>>>>>>>>>>>>> copying new repo files <<<<<<<<<<${RESET}"
cp -f mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "${RED}>>>>>>>>>>>>> Installing mongod <<<<<<<<<<${RESET}"
yum install mongodb-org -y

echo -e "${RED}>>>>>>>>>>>>> enabling mongod <<<<<<<<<<${RESET}"
systemctl enable mongod
systemctl start mongod

echo -e "${RED}>>>>>>>>>>>>> restarting mongod <<<<<<<<<<${RESET}"
systemctl restart mongod