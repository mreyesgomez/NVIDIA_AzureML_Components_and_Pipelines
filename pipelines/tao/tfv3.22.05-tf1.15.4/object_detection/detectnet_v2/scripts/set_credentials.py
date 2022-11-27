
import json

def start():
    jsonfile = open("azure_config.json")
    azuredata = json.load(jsonfile)


    with open ('scripts/config.sh', 'w') as rsh:
        rsh.writelines('#!/bin/bash\n')
        rsh.writelines('subscription_id={0}\n'.format(azuredata['azureml_user']['subscription_id']))
        rsh.writelines('resource_group={0}\n'.format(azuredata['azureml_user']['resource_group']))
        rsh.writelines('workspace_name={0}\n'.format(azuredata['azureml_user']['workspace_name']))


def go():
    start()


if __name__ == "__main__":
    go()
