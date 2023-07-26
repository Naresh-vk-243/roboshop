Red='\e[31m'
End='\e[0m'
log=/tmp/roboshop.log

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /etc/systemd/system/cart.service &>>${log}
cp -f cart.service /etc/systemd/system/cart.service&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< downloading nodejs and installing  >>>>>>>>>>>>>>${End}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash&>>${log}
yum install nodejs -y&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< roboshop user adding  >>>>>>>>>>>>>>${End}"
useradd roboshop&>>${log}

echo -e "${Red} <<<<<<<<<<<<<< creating dir nad downloading code base fro cart >>>>>>>>>>>>>>${End}"
mkdir /app&>>${log}
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip&>>${log}
cd /app&>>${log}
unzip /tmp/cart.zip&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< rinstalling dependencies  >>>>>>>>>>>>>>${End}"
cd /app&>>${log}
npm install&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< reloading daemon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload&>>${log}


echo -e "${Red} <<<<<<<<<<<<<< enabling and reloading cart service  >>>>>>>>>>>>>>${End}"
systemctl enable cart&>>${log}
systemctl restart cart&>>${log}

