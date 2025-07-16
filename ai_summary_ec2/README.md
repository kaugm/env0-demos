## Demo of AI Summary
This code doesn't work, it will result in an error (on purpose).

There is an error in the `data.aws_ami` block:
**Incorrect**: `values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd63-server-*"]`
**Correct**: `values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]`

#### Demo Steps
1. Enable GitOps workflow (Redeploy on push to Git Branch)
2. Provision environment from template, which will fail
3. Review failure in AI Summary
4. Fix code and merge back into main
5. Watch env0 automatically redeploy, and the deployment succeed
6. **Reset code back to its original state after demo!!**

#### Talk Track
In the concept of self service, a Developer isn't expected to know, or might not know IaC (Terraform in this case). When there is a failure, it might not be understood: *What in the world is a data block?*. The error that this IaC module will return will state that the "query" failed. But we aren't searching for anything, we're provisioning infrastructure. Env0 AI Summary will explain what the purpose of a data block in Terraform is and offer a high level reason *why* it failed. It will also offer ideas of what to check within the data block to resolve the issue. When reviewing the data block's configuration, you can easily see that someone fat-fingered the AMI architecture type.