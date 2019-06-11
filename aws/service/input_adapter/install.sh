#!/bin/bash

wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/service/input_adapter/docker-compose.yml
git clone https://github.com/smartheating/InputAdapter.git
sudo docker-compose up -d
