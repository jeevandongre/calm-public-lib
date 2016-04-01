#!/bin/bash
# Download and Install the Latest Updates for the OS
rootpass='Pass@word1'
apt-get update 

# Set the Server Timezone to CST
echo "Asia/Kolkata" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Install essential packages
apt-get -y install zsh htop

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server-5.6 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql

service mysql start
# Run the MySQL Secure Installation wizard
mysql -u root -p'root'<<-EOF
UPDATE mysql.user SET Password=PASSWORD('$rootpass') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF
sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf

service mysql restart
