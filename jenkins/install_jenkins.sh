# install_jenkins.sh
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install java-11-openjdk -y
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
