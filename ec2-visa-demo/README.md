## Demo Created Specifically for Visa
Demonstrate how an RBAC-scoped user can create infrastructure from a template and then update infrastructure (EC2) configurations in *day 2* operations.

#### Requirements
1. Provision EC2 from template
    - EC2 Instance Profile with a single IAM Policy
    - Security Group with a single Ingress & Egress rule
2. Redeploy (update) the infrastructure by
    - Adding an IAM policy to the EC2 Instance Profile
    - Adding a rule to the Security Group Egress


#### Demo Steps
1. Login with RBAC-Scoped user (Project Deployer Permission)
2. Deploy environment from template
3. Verify EC2 configuration in AWS
    - Single IAM Policy in EC2 Instance Profile
    - Single Security Group Egress rule
4. Redeploy environment by updating the following variables

```# egress_rules
[
  {
    "cidr_blocks": [
      "10.10.10.11/32"
    ],
    "from_port": 443,
    "protocol": "tcp",
    "to_port": 443
  },
  {
    "cidr_blocks": [
      "10.10.10.12/32"
    ],
    "from_port": 80,
    "protocol": "tcp",
    "to_port": 80
  }
]```

```# managed_policy_arns
[
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
]```

5. Verify EC2 configuration in AWS
    - 2 IAM Policies in EC2 Instance Profile
    - 2 Rules in Security Group Egress