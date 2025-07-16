## Demo of AI Summary
This code doesn't work, it will result in an error

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