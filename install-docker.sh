#!/usr/bin/env sh

echo $1
ssh user1@$1 bash -s <<- EOF
  curl -fsSL https://get.docker.com -o docker
  sudo sh ./docker

  sudo groupadd docker
  sudo usermod -aG docker user1
  newgrp docker
  
  sudo systemctl enable docker.service
  sudo systemctl enable containerd.service
EOF