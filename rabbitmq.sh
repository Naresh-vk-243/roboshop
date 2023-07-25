
RED='\e[31m'
RESET='\e[0m'


echo -e "${RED}>>>>>>>>>>>>> dwoanloading erlang for rabbtmqx <<<<<<<<<<${RESET}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "${RED}>>>>>>>>>>> dwoanloading rabbitmq <<<<<<<<<<<<<<"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash


echo -e "${RED}>>>>>>>>>>>>> installing rabbitmq <<<<<<<<<<<<<<<<<<<${RESET}"
yum install rabbitmq-server -y


echo -e "${RED}>>>>>>>>>>>>> enabling and restarting rabbitmq <<<<<<<<<<<<<<<<<<<${RESET}"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

echo -e "${RED}>>>>>>>>>>>>> adding user and giving set_permissions <<<<<<<<<<<<<<<<<<<${RESET}"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
