### Cloud to Code Demo
For demonstrating env0's drift remediation feature. The `main.tf` file creates an S3 Bucket with an insecure bucket policy, allowing public read of objects. 

### Instructions
1. Show insecure bucket policy
2. Remove the bucket policy (Either in the UI or by running `aws s3api delete-bucket-policy --bucket $BUCKET`, or by script)
3. Show bucket policy has been removed
4. Trigger drift detection via API
5. Show drift detection deployment in progress
6. Navigate to this repo, inspect, and merge PR

