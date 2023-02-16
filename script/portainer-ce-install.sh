#!/bin/bash

# 创建 Docker volume
docker volume create portainer_data

# 启动 Portainer Community Edition
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest