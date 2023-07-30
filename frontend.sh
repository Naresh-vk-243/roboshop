log=/tmp/roboshop.log

component=nginx
source commonFuncs.sh


echo -e "\e[36m>>>>>>>>>>>>  Install Nginx   <<<<<<<<<<<<\e[0m"
yum install nginx -y &>>${log}
func_exit_status


echo -e "\e[36m>>>>>>>>>>>>  Copy RoboShop Configuration  <<<<<<<<<<<<\e[0m"
rm -rf /etc/nginx/default.d/roboshop.conf
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
func_exit_status


echo -e "\e[36m>>>>>>>>>>>>  Clean Old content  <<<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/* &>>${log}
func_exit_status


echo -e "\e[36m>>>>>>>>>>>>  Download Application Content   <<<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
func_exit_status

cd /usr/share/nginx/html

echo -e "\e[36m>>>>>>>>>>>>  Extract Application Content  <<<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip &>>${log}
func_exit_status


echo -e "\e[36m>>>>>>>>>>>>  Start Nginx Service  <<<<<<<<<<<<\e[0m"
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}
func_exit_status