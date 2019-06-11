#!/bin/bash

wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/service/repository/docker-compose.yml
git clone https://github.com/smartheating/Repository.git
sudo docker-compose up -d
