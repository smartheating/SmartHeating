#!/usr/bin/env python3

# This script starts one or more smart_heating components in a docker in an ec2 instance
import boto3

region = 'us-east-1'
ami = "ami-09aa8a9160d48ad53"

services = {
    "1": "mysql",
    "2": "rabbitmq",
    "3": "service_registration",
    "4": "cloud_gateway"
}

print("\nAvailable services:")
print("[0] all")
for k,v in services.items():
    print("[{}] {}".format(k,v))

print("Choose one: ")
usr_in = input()

def deploy(service_name):
    install_script = """#!/bin/bash
    mkdir smart_heating
    cd smart_heating
    wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/{}/docker-compose.yml
    sudo docker-compose up -d
    """.format(service_name)
    ec2 = boto3.resource("ec2", region_name='us-east-1')
    response = ec2.create_instances(
        TagSpecifications=[{
                "ResourceType": "instance", 
                "Tags": [{
                    "Key": "Name",
                    "Value": "{}".format(service_name)}]}],
        ImageId=ami,
        InstanceType="t2.micro",
        MinCount=1,
        MaxCount=1,
        UserData=install_script ,
        SecurityGroups=["launch-wizard-1"],
        KeyName="smart_heating")
    print(response)

if usr_in is "0":
    for _,v in services.items():
        deploy(v)
else:
    deploy(service_name.get(usr_in))
