import boto3
from tabulate import tabulate


def get_instances(state_name='running') -> boto3:
    if isinstance(state_name, list): states = state_name
    else: states = [state_name]
    ec2 = boto3.resource('ec2')
    filters = [{'Name': 'instance-state-name', 'Values': states}]
    instances = [_ for _ in ec2.instances.filter(Filters=filters)]
    return instances


def get_table(instances):
    if instances == None:
        instances = []
    tab_data = [['[{}]'.format(i), '' if instance.tags is None else instance.tags[0]['Value'], instance.id, instance.public_ip_address, instance.state['Name']]
                for instance, i in zip(instances, range(1, len(instances) + 1))]
    return tabulate(tab_data, headers=['[number]', 'name', 'id', 'ip', 'state'])


