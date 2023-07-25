Red="\e[30m"
End="\e[0m"

echo  -e "${Red} <<<<<<<<<<<<<< Downloading the Redis rpm file which contains all versions >>>>>>>>>>>>>>${End}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

#echo  -e "${Red} <<<<<<<<<<<<<< Enabling the 6.2 veriosn from rpm file >>>>>>>>>>>>>>${End}"
echo -e "${RED}>>>>>>>>>>>>> Installing nginx <<<<<<<<<<${RESET}"
yum module enable redis:remi-6.2 -y



echo  -e "${Red} <<<<<<<<<<<<<< installing the redis >>>>>>>>>>>>>>${End}"
yum install redis -y


echo  -e "${Red} <<<<<<<<<<<<<< replacing the ip address to 0.0.0.0  >>>>>>>>>>>>>>${End}"
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf /etc/redis/redis.conf

echo  -e "${Red} <<<<<<<<<<<<<< Enabling and restarting redis >>>>>>>>>>>>>>${End}"
systemctl enable redis 
systemctl restart redis 


#
#echo -e "${Red} <<<<<<<<<<<<<<  >>>>>>>>>>>>>>${End}"
#
#echo -e "${Red} <<<<<<<<<<<<<<  >>>>>>>>>>>>>>${End}"