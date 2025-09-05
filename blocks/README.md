## Build Terraform / OpenTofu Environments with "Blocks"
Attempting to replicate *lego functionality* with individual Terraform modules linked together in a workflow.

The resources in this example are arbitrary, used as an example, and represent only a *subset* of a potential application.

IAM is an issue here.

#### Initial State
Create a DynamoDB table.

```DynamoDB```

#### Next State (Add Components)
Take updates to DynamoDB items, process them, and update a file in S3.

```DynamoDB (Streams) --> Lambda --> S3```

#### Eventual State (Injecting Components)
Add a **Fan Out** pattern, so that additional Lambdas can process DynamoDB Streams.

```
DynamoDB (Streams) --> SNS --> Lambda --> S3
                         | --> Lambda --> ?
```

#### Eventual State (Replacing Components)
Intead of modifying a file in S3, load them into another DynamoDB table.

```DynamoDB (Streams) --> Lambda --> DynamoDB```