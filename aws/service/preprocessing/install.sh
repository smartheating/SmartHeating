#!/bin/bash

wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/service/preprocessing/docker-compose.yml
git clone https://github.com/smartheating/Preprocessing.git
sudo docker-compose up -d
