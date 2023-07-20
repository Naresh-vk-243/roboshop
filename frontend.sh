sudo -s
sudo set-hostname frontend
yum install nginx -y

cp -f roboshop.conf /etc/nginx/default.d/

systemctl enable nginx
systemctl restart nginx

rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

systemctl restart nginx
