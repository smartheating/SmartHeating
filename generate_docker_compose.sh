#!/bin/bash

# Any subsequent commands stop when an error occurs
set -e

# define path variables
default_mac_datadir="/usr/local/var/smart_heating/mysql"
default_mac_rabbitmqdir="/usr/local/var/smart_heating/rabbitmq"
default_linux_datadir="/var/lib/smart_heating/mysql"
default_linux_rabbitmqdir="/var/lib/smart_heating/rabbitmq"
default_win_datadir="C:/Users/user/Documents/Docker/MySQL:/var/lib/mysql"
default_win_rabbitmqdir="C:/Users/user/Documents/Docker/RabbitMQ:/var/lib/rabbitmq/mnesia"

# Find out the operating system
os="$(uname -s)"
echo ""

# Volume setup: MySQL
echo "Setup: MySQL"
echo "¯¯¯¯¯¯¯¯¯¯¯¯"
echo "This setup will deploy SmartHeating on your local machine."
echo "Please provide a path, in which MySQL can store its data."

if [[ $os == "Darwin" ]]
then
    echo "Default is: "$default_mac_datadir
elif [[ $os == "Linux" ]]
then
    echo "Default is: "$default_linux_datadir
else 
    echo "Default is: "$default_win_datadir
fi

read datadir


if [[ "$os" == "Darwin" && "$datadir" == "" ]] 
then
    datadir=$default_mac_datadir
elif [[ "$os" == "Linux" && "$datadir" == "" ]]
then
    datadir=$default_linux_datadir
elif [[ "$datadir" == "" ]]
then
    datadir=$default_win_datadir
fi

echo "Chosen value: "$datadir 

if [[ ! -d "$datadir" ]]
then
    echo "create data directory for MySQL..."
    mkdir -p "$datadir"
fi

echo ""

# Volume setup: RabbitMQ
echo "Setup: RabbitMQ"
echo "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"
echo "Please provide a path, in which RabbitMQ can store its data."
if [[ $os == "Darwin" ]]
then
    echo "Default is: "$default_mac_rabbitmqdir
elif [[ $os == "Linux" ]]
then
    echo "Default is: "$default_linux_rabbitmqdir
else 
    echo "Default is: "$default_win_rabbitmqdir
fi
read messagingdir

if [[ "$os" == "Darwin" && "$datadir" == "" ]] 
then
    messagingdir=$default_mac_rabbitmqdir
elif [[ "$os" == "Linux" && "$datadir" == "" ]]
then
    messagingdir=$default_linux_rabbitmqdir
elif [[ "$datadir" == "" ]]
then
    messagingdir=$default_win_rabbitmqdir
fi

echo "Chosen value:" $messagingdir

if [[ ! -d "$messagingdir" ]]
then
    echo "create messaging directory for RabbitMQ..."
    mkdir -p "$messagingdir"
fi

# Prepare docker-compose
echo "Generate docker-compose.yml file"
echo "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯"
echo "create file..."
cp template/template_docker-compose.yml /tmp/docker-compose.yml

sed -i 's,{REPLACE THIS WITH YOUR LOCAL PATH}:/var/lib/mysql,'"$datadir"':/var/lib/mysql,g' /tmp/docker-compose.yml
sed -i 's,{REPLACE THIS WITH YOUR LOCAL PATH}:/var/lib/rabbitmq/mnesia,'"$datadir"':/var/lib/rabbitmq/mnesia,g' /tmp/docker-compose.yml

mv /tmp/docker-compose.yml docker-compose.yml


echo "finished: docker-compose.yml was generated"
echo ""