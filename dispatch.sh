Red='\e[31m'
End='\e[0m'

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/dispatch.zip /etc/systemd/system/dispatch.service&>>${log}
cp -f dispatch.service /etc/systemd/system/dispatch.service&>>${log}

echo -e "${Red} <<<<<<<<<<<<<< installing golang >>>>>>>>>>>>>>${End}"
yum install golang -y&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< adding roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app&>>${log}
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip&>>${log}
cd /app&>>${log}
unzip /tmp/dispatch.zip&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app&>>${log}
go mod init dispatch&>>${log}
go get&>>${log}
go build&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable dispatch&>>${log}
systemctl restart dispatch&>>${log}
