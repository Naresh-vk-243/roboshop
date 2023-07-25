log=/tmp/roboshop.log
RED='\e[31m'
RESET='\e[0m'


echo -e "${RED}>>>>>>>>>>>>> dwoanloading erlang for rabbtmqx <<<<<<<<<<${RESET}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log}

echo -e "${RED}>>>>>>>>>>> dwoanloading rabbitmq <<<<<<<<<<<<<<"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log}


echo -e "${RED}>>>>>>>>>>>>> installing rabbitmq <<<<<<<<<<<<<<<<<<<${RESET}"
yum install rabbitmq-server -y &>>${log}


echo -e "${RED}>>>>>>>>>>>>> enabling and restarting rabbitmq <<<<<<<<<<<<<<<<<<<${RESET}"
systemctl enable rabbitmq-server&>>${log}
systemctl restart rabbitmq-server&>>${log}

echo -e "${RED}>>>>>>>>>>>>> adding user and giving set_permissions <<<<<<<<<<<<<<<<<<<${RESET}"
rabbitmqctl add_user roboshop roboshop123&>>${log}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"&>>${log}
