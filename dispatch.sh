Red="\e[30m"
End="\e[0m"

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/dispatch.zip /etc/systemd/system/dispatch.service
cp -f dispatch.service /etc/systemd/system/dispatch.service

echo -e "${Red} <<<<<<<<<<<<<< installing golang >>>>>>>>>>>>>>${End}"
yum install golang -y


echo -e "${Red} <<<<<<<<<<<<<< adding roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop


echo -e "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip


echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
go mod init dispatch
go get
go build


echo -e "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo -e "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user
systemctl restart user
