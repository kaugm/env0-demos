# IMPORTANT!

How this works

1. We need to install SAM CLI, as it is not installed by default in the deployment container
2. Once we clone the SAM templates, we need to convert them into CloudFormation templates
3. The template is pre-configured to deploy a CloudFormation template of a specific name. As such we need to ensure that the name is set as an environment variable, or hardcoded in the custom flow (env0.yaml file)
4. env0+CloudFormation will look for this .yaml file in order to continue with the deployment process


### Requirements
Environment Variables
1. `AWS_REGION`
2. `GENERATED_TEMPLATE_FILE_NAME` (Must include `.yaml` file type suffix. e.g. generated-template.yaml)

Approve plan automatically (or modify env0.yaml file to confirm installation of SAM CLI - it gets stuck during approval)