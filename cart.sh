Red='\e[30m'
End='\e[0m'

echo -e "${Red} <<<<<<<<<<<<<< removig and copying files  >>>>>>>>>>>>>>${End}"
rm -rf /app /etc/systemd/system/cart.service
cp -f cart.service /etc/systemd/system/cart.service


echo -e "${Red} <<<<<<<<<<<<<< downloading nodejs and installing  >>>>>>>>>>>>>>${End}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y


echo -e "${Red} <<<<<<<<<<<<<< roboshop user adding  >>>>>>>>>>>>>>${End}"
useradd roboshop

echo -e "${Red} <<<<<<<<<<<<<< creating dir nad downloading code base fro cart >>>>>>>>>>>>>>${End}"
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip


echo -e "${Red} <<<<<<<<<<<<<< rinstalling dependencies  >>>>>>>>>>>>>>${End}"
cd /app
npm install


echo -e "${Red} <<<<<<<<<<<<<< reloading daemon >>>>>>>>>>>>>>${End}"
systemctl daemon-reload


echo -e "${Red} <<<<<<<<<<<<<< enabling and reloading cart service  >>>>>>>>>>>>>>${End}"
systemctl enable cart
systemctl restart cart

