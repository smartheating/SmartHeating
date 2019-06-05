#!/usr/bin/env python3

import os
import boto3
from tabulate import tabulate

pem = os.environ.get("SMART_HEATING_PEM")
if pem is None:
    print("Please provide the path to your AWS keys (smart_heating.pem):")
    pem = input()

ec2 = boto3.resource('ec2')
filters = [{'Name': 'instance-state-name', 'Values': ['running']}]
instances = [_ for _ in ec2.instances.filter(Filters=filters)]

i = 0
print("Please choose the number of the instance, which you want to access via SSH:")
tab_data = [["[{}]".format(i), instance.tags[0]["Value"], instance.id, instance.public_ip_address]
            for instance, i in zip(instances, range(1, len(instances)+1))]
print(tabulate(tab_data, headers=["[number]", "name", "id", "ip"]))
instance = int(input())


os.system("ssh -i ~/.aws/cloud_computing.pem ubuntu@{}".format(instances[instance-1].public_ip_address))
