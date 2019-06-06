#!/bin/bash

if [ "$1" == "-a" ]
then
    aws ec2 describe-instances --query "Reservations[].Instances[].{name:Tags[0].Value, id:InstanceId, state:State.Name, ip: PublicIpAddress}" --output table    
else
    aws ec2 describe-instances --filter "Name=instance-state-code, Values=16" --query "Reservations[].Instances[].{name:Tags[0].Value, id:InstanceId, state:State.Name, ip: PublicIpAddress}" --output table     
fi
