# SmartHeating

## Introduction
The goal of our smart heating system is to save energy costs by dynamically controlling the heat supply in a house, 
depending on whether or not someone is at home. Using a variety of sensors, it can detect the user’s presence. 
It can also estimate the time when the user will arrive at home based on GPS data, to preheat the house to a comfortable temperature.

## Installation
First, you have to generate the docker-compose.yml. Go to the SmartHeating directory (this repository). 
Then make sure that `generate_docker_compose.sh` is executable:
```bash
sudo chmod u+x generate_docker_compose.sh
```
Afterwards you can generate `docker_compose.yml` by executing the script:
```bash
./generate_docker_compose.sh 
```
Finally you can start the microservices: 
```bash
docker-compose up
```

## Some useful stuff
#### Start single microservice
You can start each microservice by typing `docker-compose up <MICROSERVICE NAME>`. By doing so you also start 
its dependencies (e.g. MySQL or RabbitMQ). The following example starts only repository (the database service): 
```bash
docker-compose up repository 
```
#### Swagger-UI
Each microservice provides a Swagger-UI. You can use them for playing and testing. Every Swagger-UI can be accessed 
in the browser with the following URL `http://localhost:9001/<MICROSERVICE NAME>/swagger-ui.html#/`. 
E.g. if you want to access the Swagger-UI of the `testservice`, use the following URL:
```bash
http://localhost:9001/testservice/swagger-ui.html#/
```
