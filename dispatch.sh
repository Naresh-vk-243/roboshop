component=dispatch
source commonFuncs.sh

copy_and_remove_files

echo -e "${Red} <<<<<<<<<<<<<< installing golang >>>>>>>>>>>>>>${End}"
yum install golang -y&>>${log}

adduser_downloadCode_unzip

echo -e "${Red} <<<<<<<<<<<<<< installing dependencies >>>>>>>>>>>>>>${End}"
cd /app&>>${log}
go mod init dispatch&>>${log}
go get&>>${log}
go build&>>${log}

restarting_enabling_service
