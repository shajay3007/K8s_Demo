#!/bin/bash

echo "|"
echo "|"
echo "====== Java ==========="
echo "|"
echo "|"
sudo apt update -y
sudo apt install fontconfig openjdk-17-jre
java -version
echo "|"
echo "|"
echo "========= Docker install ====="
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
sudo newgrp docker
docker pull sonarqube

# echo "====== Kind====="
:'
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo cp ./kind /usr/local/bin/kind

VERSION="v1.30.0" 
URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
INSTALL_DIR="/usr/local/bin"

curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/
kubectl version --client

rm -f kubectl
rm -rf kind
EOF
echo "kind & kubectl installation complete."
'