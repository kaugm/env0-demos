# Interact with Deployment
There are 3 ways to interact with Kubernetes Deployments with env0:
1. Via Kubectl (the traditional way). This is independent from env0, and hence, irrelevant for demos
2. Using env0's GitOps workflows or CD
3. Run Tasks (code below)

```
kubectl get pods -l app=nginx -o json | jq '.items | length'
kubectl scale deployment/nginx-deployment --replicas=1
sleep 5
kubectl get pods -l app=nginx -o json | jq '.items | length'
```