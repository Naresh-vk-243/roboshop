#sudo -s
#sudo set-hostname frontend
log=/tmp/roboshop.log
RED='\e[31m'
RESET='\e[0m'


echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
yum install nginx -y&>>${log}
cp -f roboshop.conf /etc/nginx/default.d/&>>${log}


echo -e "${RED}>>>>>>>>>>> starting nginx <<<<<<<<<<<<<<"
systemctl enable nginx&>>${log}
systemctl restart nginx&>>${log}


echo -e "${RED}>>>>>>>>>>>>> Removing nginx file <<<<<<<<<<<<<<<<<<<${RESET}"
rm -rf /usr/share/nginx/html/*&>>${log}


echo -e "${RED}>>>>>>>>>>>>> downloading Frontend code <<<<<<<<<<<<<<<<<<<${RESET}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip&>>${log}
cd /usr/share/nginx/html&>>${log}
unzip /tmp/frontend.zip&>>${log}

echo -e "${RED}>>>>>>>>>>>>> restarting nginx <<<<<<<<<<<<<<<<<<<${RESET}"
systemctl restart nginx&>>${log}

