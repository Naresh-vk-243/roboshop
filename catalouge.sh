curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop

cp -f catalogue.service /etc/systemd/system/catalogue.service
cp -f mongo.repo /etc/yum.repos.d/mongo.repo

mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install


systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
yum install mongodb-org-shell -y

mongo --host 172.31.89.103 </app/schema/catalogue.js