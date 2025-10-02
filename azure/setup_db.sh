sudo yum update -y
sudo yum install mysql-server -y
sudo systemctl start mysqld
sudo systemctl enable mysqld

mysql -u root <<EOF
CREATE DATABASE bookdb;
USE bookdb;
CREATE TABLE book (
    bookid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    author VARCHAR(100),
    price DECIMAL(6,2)
);
EOF
