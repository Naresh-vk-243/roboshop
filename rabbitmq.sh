log=/tmp/roboshop.log
RED='\e[31m'
RESET='\e[0m'

component=rabbitmq-server
source commonFuncs.sh

echo -e "${RED}>>>>>>>>>>>>> dwoanloading erlang for rabbtmqx <<<<<<<<<<${RESET}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log}

echo -e "${RED}>>>>>>>>>>> dwoanloading rabbitmq <<<<<<<<<<<<<<"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log}


echo -e "${RED}>>>>>>>>>>>>> installing rabbitmq <<<<<<<<<<<<<<<<<<<${RESET}"
yum install rabbitmq-server -y &>>${log}


starting_enabling_without_daemon

echo -e "${RED}>>>>>>>>>>>>> adding user and giving set_permissions <<<<<<<<<<<<<<<<<<<${RESET}"
rabbitmqctl add_user roboshop roboshop123&>>${log}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"&>>${log}
