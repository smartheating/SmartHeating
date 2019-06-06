#!/bin/bash

wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/service_registration/docker-compose.yml
git clone https://github.com/smartheating/ServiceRegistration.git
sudo docker-compose up -d