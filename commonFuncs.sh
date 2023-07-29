Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

copy_and_remove_files() {
  echo -e "${Red} <<<<<<<<<<<<<< removing and copying files  >>>>>>>>>>>>>>${End}"
  rm -rf /app /etc/systemd/system/${component}.service /tmp/${component}.zip &>>${log}
  cp -f ${component}.service /etc/systemd/system/${component}.service &>>${log}
}

copy_and_remove_Repo_files() {

  echo -e "${Red} <<<<<<<<<<<<<< removing and copying files  >>>>>>>>>>>>>>${End}"
  rm -rf /etc/yum.repos.d/${component}.repo &>>${log}
  cp -f ${component}.repo /etc/yum.repos.d/${component}.repo &>>${log}
}

adduser_downloadCode_unzip() {
  echo -e "${Red} <<<<<<<<<<<<<< roboshop user adding  >>>>>>>>>>>>>>${End}"
  useradd roboshop &>>${log}

  echo -e "${Red} <<<<<<<<<<<<<< creating dir nad downloading code base for ${component} >>>>>>>>>>>>>>${End}"
  mkdir /app &>>${log}
  curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

  cd /app &>>${log}
  unzip /tmp/${component}.zip &>>${log}

}
restarting_enabling_service() {
  echo -e "${Red} <<<<<<<<<<<<<< reloading daemon >>>>>>>>>>>>>>${End}"
  systemctl daemon-reload &>>${log}

  echo -e "${Red} <<<<<<<<<<<<<< enabling and reloading ${component} service  >>>>>>>>>>>>>>${End}"
  systemctl enable ${component} &>>${log}
  systemctl restart ${component} &>>${log}
}

starting_enabling_without_daemon() {
  echo -e "${RED}>>>>>>>>>>>>> enabling mongod <<<<<<<<<<${RESET}"
  systemctl enable ${component} &>>${log}
  systemctl start ${component} &>>${log}

  echo -e "${RED}>>>>>>>>>>>>> restarting mongod <<<<<<<<<<${RESET}"
  systemctl restart ${component} &>>${log}
}

func_schema_setup() {
  if [ "${schema_type}" == "mongodb" ]; then
    echo -e "\e[36m>>>>>>>>>>>>  INstall Mongo Client  <<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
    copy_and_remove_Repo_files
    yum install mongodb-org-shell -y &>>${log}
    func_exit_status

    echo -e "\e[36m>>>>>>>>>>>>  Load User Schema  <<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
    mongo --host mongodb.nareshdevops.cloud </app/schema/${component}.js &>>${log}
    func_exit_status
  fi

  if [ "${schema_type}" == "mysql" ]; then
    echo -e "\e[36m>>>>>>>>>>>>  Install MySQL Client   <<<<<<<<<<<<\e[0m"
    yum install mysql -y &>>${log}
    func_exit_status

    echo -e "\e[36m>>>>>>>>>>>>  Load Schema   <<<<<<<<<<<<\e[0m"
    mysql -h mysql.nareshdevops.cloud -uroot -pRoboShop@1 </app/schema/${component}.sql &>>${log}
    func_exit_status
  fi

}

install_nodeJs() {
  copy_and_remove_files

  echo -e "${Red} <<<<<<<<<<<<<< downloading nodejs and installing  >>>>>>>>>>>>>>${End}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
  yum install nodejs -y &>>${log}

  echo -e "${Red} <<<<<<<<<<<<<< installing dependencies  >>>>>>>>>>>>>>${End}"
  cd /app &>>${log}
  npm install &>>${log}

  adduser_downloadCode_unzip
  func_schema_setup
  restarting_enabling_service
}

install_Python() {
  copy_and_remove_files

  echo -e "${Red} <<<<<<<<<<<<<< installing python >>>>>>>>>>>>>>${End}"
  yum install python36 gcc python3-devel -y &>>${log}

  adduser_downloadCode_unzip

sed -i "s/rabbitmq_app_password/${rabbitmq_app_password}/" /etc/systemd/system/${component}.service

  echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
  cd /app &>>${log}
  pip3.6 install -r requirements.txt &>>${log}

  restarting_enabling_service
}

install_maven_java() {

  copy_and_remove_files

  echo -e "${Red} <<<<<<<<<<<<<< installing maven >>>>>>>>>>>>>>${End}"
  yum install maven -y &>>${log}

  adduser_downloadCode_unzip

  echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
  cd /app &>>${log}
  mvn clean package &>>${log}
  mv target/${component}-1.0.jar ${component}.jar &>>${log}

  func_schema_setup

  restarting_enabling_service
}
