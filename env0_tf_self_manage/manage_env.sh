#!//usr/bin/python3

import os
import requests
import sys

# Require Template ID
if len(sys.argv) > 1:
    COMMAND = sys.argv[1]

    # Validate command
    if COMMAND not in ('deploy', 'destroy'):
        print(f"Valid options are 'deploy' and 'destroy'. You put {sys.argv[1]}")
        os._exit(1)

    ID = sys.argv[2]
else:
    print("Please provide a command and template id.")
    os._exit(1)

# Hardcoding because I'm lazy
ORGANIZATION_ID = "bde19c6d-d0dc-4b11-a951-8f43fe49db92"
PROJECT_ID = "07e24ae9-65b0-40b8-b360-5a9228323add"

API_KEY_ID = os.environ['TF_VAR_ENV0_KEY_ID']
API_KEY_SECRET = os.environ['TF_VAR_ENV0_KEY_SECRET']
API_TOKEN = os.environ['ENV0_TOKEN']

deploy_endpoint = "https://api.env0.com/environments"
destroy_endpoint = f"https://api.env0.com/environments/{ID}/destroy"


def deploy_from_template():
    '''
    Deploy an environment to Env0 from a pre-existing template.
    '''
    headers = {
        "accept": "application/json",
        "content-type": "application/json"
    }
    payload = {
        "name": "Karl-env-from-template-api",
        "projectId": PROJECT_ID,
        "deployRequest": {
            "blueprintId": ID
        },
        "isRemoteBackend": True
    }


    try:
        response = requests.post(
            deploy_endpoint,
            auth=(API_KEY_ID, API_KEY_SECRET),
            json=payload,
            headers=headers
        )

        # Check the response status and content
        response.raise_for_status()  # This will raise an HTTPError for bad responses (4xx or 5xx)
        print("Authentication successful!\n")
        # print(response.json())

        r = response.json()
        print(f"Please navigate to: https://app.env0.com/p/{PROJECT_ID}/environments/{r['latestDeploymentLog']['environmentId']}?organizationId=ORGANIZATION_ID")
        print(f"\nEnvironment ID: {r['latestDeploymentLog']['environmentId']}")

    except requests.exceptions.HTTPError as err:
        print(f"HTTP Error: {err}")
        print(f"Response body: {err.response.text}")
    except Exception as err:
        print(f"An error occurred: {err}")

def destroy_environment():
    '''
    Destroy an Env0 environment.
    '''
    headers = {
        "accept": "application/json",
        "content-type": "application/json"
    }

    try:
        response = requests.post(
            destroy_endpoint,
            auth=(API_KEY_ID, API_KEY_SECRET),
            headers=headers
        )

        # Check the response status and content
        response.raise_for_status()  # This will raise an HTTPError for bad responses (4xx or 5xx)
        print("Authentication successful!\n")
        # print(response.json())

        r = response.json()
        print(f"Environment {ID} is being destroyed.")

    except requests.exceptions.HTTPError as err:
        print(f"HTTP Error: {err}")
        print(f"Response body: {err.response.text}")
    except Exception as err:
        print(f"An error occurred: {err}")



if __name__ == '__main__':

    if COMMAND == "deploy":
        deploy_from_template()

    if COMMAND == "destroy":
        destroy_environment()


