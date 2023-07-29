component=frontend
source commonFuncs.sh

echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
yum install nginx -y&>>${log}
cp -f roboshop.conf /etc/nginx/default.d/&>>${log}

starting_enabling_without_daemon

echo -e "${RED}>>>>>>>>>>>>> Removing nginx file <<<<<<<<<<<<<<<<<<<${RESET}"
rm -rf /usr/share/nginx/html/*&>>${log}

adduser_downloadCode_unzip

starting_enabling_without_daemon
