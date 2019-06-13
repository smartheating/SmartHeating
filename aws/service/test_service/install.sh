#!/bin/bash

wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/service/test_service/docker-compose.yml
git clone https://github.com/smartheating/TestService.git
sudo docker-compose up -d
