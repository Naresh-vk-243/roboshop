RED='\e[31m'
RESET='\e[0m'
log=/tmp/roboshop.log

component=mongod
source commonFuncs.sh


copy_and_remove_Repo_files

echo -e "${RED}>>>>>>>>>>>>> Installing mongod <<<<<<<<<<${RESET}"
yum install mongodb-org -y &>>${log}

echo  "${RED} <<<<<<<<<<<<<< replacing the ip address to 0.0.0.0  >>>>>>>>>>>>>>${RESET}"
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf &>>${log}

starting_enabling_without_daemon