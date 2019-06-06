#!/bin/bash

wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/cloud_gateway/docker-compose.yml
git clone https://github.com/smartheating/CloudGateway.git
sudo docker-compose up -d