#sudo -s
#sudo set-hostname frontend

RED='\e[31m'
RESET='\e[0m'


echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}";
yum install nginx -y
cp -f roboshop.conf /etc/nginx/default.d/

echo -e "${RED}>>>>>>>>>>> starting nginx <<<<<<<<<<<<<<"
systemctl enable nginx
systemctl restart nginx

echo -e "${RED}>>>>>>>>>>>>> Removing nginx file <<<<<<<<<<<<<<<<<<<${RESET}"
rm -rf /usr/share/nginx/html/*

echo -e "${RED}>>>>>>>>>>>>> downloading Frontend code <<<<<<<<<<<<<<<<<<<${RESET}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

systemctl restart nginx

