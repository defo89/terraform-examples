import boto3

def instances_find(tag_name, tag_value):
    '''
    Finds instance id's based on tags.
    Returns a list of instances found.
    '''
    list_instances = []
    filters =[
        {
        'Name': tag_name,
        'Values': [
            tag_value,
            ]
        },
    ]
    instances = ec2_resource.instances.filter(Filters=filters)
    for instance in instances:
        # for each instance, append to list
        list_instances.append(instance.id)
    return list_instances

def instances_stop(list):
    '''
    Stops instances defined in the list.
    '''
    ec2_client.stop_instances(InstanceIds=list)

def lambda_handler(event, context):
    tag_name = 'tag:environment'
    tag_value = 'dev'
    ec2_list = instances_find(tag_name, tag_value)
    ec2_stop = instances_stop(ec2_list)
    print('stopped instances: ' + str(ec2_list))

ec2_resource = boto3.resource('ec2')
ec2_client = boto3.client('ec2')

