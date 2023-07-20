sudo -s
sudo set-hostname frontend

mv -rf roboshop.conf /etc/nginx/default.d/
yum install nginx


systemctl enable nginx

systemctl restart nginx
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip


systemctl restart nginx
