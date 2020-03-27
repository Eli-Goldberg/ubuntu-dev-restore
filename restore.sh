#!/bin/bash

echo 'Obtaining sudo password'
sudo ps &> /dev/null

echo ================================ Installing Google chrome ================================
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update -y
sudo apt install -y google-chrome-stable 

echo ================================ Installing Basic tools ================================
sudo apt install -y htop git curl terminator xclip

echo ================================ Installing Python ================================
sudo apt install -y python python3 python-pip python3-pip

echo ================================ Installing AWS CLI (v2) ================================
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install

echo ================================ Installing ZSH + Oh my zsh ================================
sudo apt install -y zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# If shell doesn't change - Edit default shell
# sudo vi /etc/passwd
# username:x:1634231:100:Your Name:/home/username:/bin/bash
# and replace bash with zsh:
# username:x:1634231:100:Your Name:/home/username:/bin/zsh


echo ================================ Insatlling Node (NVM) ================================
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

sudo apt upgrade -y


echo ================================ Insatlling Golang ================================
wget https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz
sudo tar -xvf go1.14.1.linux-amd64.tar.gz
sudo mv go /usr/local

mkdir -p ~/dev/go
echo -e '\nexport GOROOT=/usr/local/go' >> ~/.zshrc
echo -e '\nexport GOPATH=$HOME/dev/go' >> ~/.zshrc
echo -e '\nexport PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.zshrc



echo ================================ Installing Docker ================================
# Remove old versions
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# For ubuntu 19 (eoan) there is no docker PPA repo yet, use the one for ubuntu 18 (bionic)
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world

echo ================================ Installing docker-compose ================================
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

