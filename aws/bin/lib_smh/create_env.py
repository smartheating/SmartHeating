import boto3
import os


if __name__ == '__main__':
    ec2 = boto3.resource('ec2')
    filters = [{'Name': 'instance-state-name', 'Values': ['running']}]
    instances = [_ for _ in ec2.instances.filter(Filters=filters)]
    out_str = 'PRIVATE_IP={}PUBLIC_IP={}'.format(
        os.popen("ifconfig eth0 | grep 'inet addr:' | cut -d ':' -f2 | awk '{print $1}'").read(),
        os.popen("curl 'ifconfig.co'").read()
    )
    for instance in instances:
        name = instance.tags[0]['Value'].upper()
        out_str = out_str + '{}_PRIVATE_IP={}\n'.format(name, instance.private_ip_address)
    with open('/smart_heating/.env', 'w') as f:
        f.write(out_str)
