package env0.deployment

default allow = false

pending[message] {
    # Check if any resource in the input is of an AWS IAM type.
    some k, v in input.resource
    startswith(v.type, "aws_iam_")

    # Set the denial message.
    message := "IAM resource detected. Deployment requires approval."

    message := sprintf("SECURITY RULE 2: Require approval from CloudOps Admins Team if IAM resource is present in plan. IAM resource '%s' is not allowed", [input.resource])
}

# Only allow approval from specified team
allow[format(rego.metadata.rule())] {
    some i
    some j
    input approvers[i].teams[j].name == "CloudOps Admins"
}
