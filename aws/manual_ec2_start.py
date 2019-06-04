import boto3

region = 'us-east-1'
ami = "ami-09aa8a9160d48ad53"

services = {
    "1": "mysql",
    "2": "rabbitmq"
}

print("\nAvailable services:")

for k,v in services.items():
    print("[{}] {}".format(k,v))

print("Choose one: ")
usr_in = input()


install_script = """#!/bin/bash
mkdir smart_heating
cd smart_heating
wget https://raw.githubusercontent.com/smartheating/SmartHeating/master/aws/{}/docker-compose.yml
sudo docker-compose up -d
""".format(usr_in)

ec2 = boto3.resource("ec2", region_name='us-east-1')

response = ec2.create_instances(
    TagSpecifications=[
        {
            "ResourceType": "instance", 
            "Tags": [{
                "Key": "Name",
                "Value": "{}".format(services.get(usr_in))
            }]
        }
    ],
    ImageId=ami,
    InstanceType="t2.micro",
    MinCount=1,
    MaxCount=1,
    UserData=install_script ,
    SecurityGroups=["launch-wizard-1"],
    KeyName="cloud_computing"
)
print(response)
