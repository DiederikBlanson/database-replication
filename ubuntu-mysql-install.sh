# source: https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04
sudo su

# Update apt
apt-get update

# Install mysql server
apt-get install mysql-server

# start mysql
systemctl start mysql

# allow port
ufw allow 3306/tcp

# change bind-address to 0.0.0.0
# in /etc/mysql/mysql.conf.d/mysqld.cnf

# restart mysql
systemctl restart mysql
