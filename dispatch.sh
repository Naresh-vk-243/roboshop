Red="\e[30m"
End="\e[0m"

echo "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /tmp/dispatch.zip /etc/systemd/system/dispatch.service
cp -f dispatch.service /etc/systemd/system/dispatch.service

echo "${Red} <<<<<<<<<<<<<< installing golang >>>>>>>>>>>>>>${End}"
yum install golang -y


echo "${Red} <<<<<<<<<<<<<< adding roboshop user  >>>>>>>>>>>>>>${End}"
useradd roboshop


echo "${Red} <<<<<<<<<<<<<< adding dir and downlaoding app code >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip


echo "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app
go mod init dispatch
go get
go build


echo "${Red} <<<<<<<<<<<<<< reloadig deamon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo "${Red} <<<<<<<<<<<<<< enabling user >>>>>>>>>>>>>>${End}"
systemctl enable user
systemctl restart user
