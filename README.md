# docker-test-irsa

A Docker image for testing IRSA using the aws-cli

## Pre-requisites

- You are already running an AWS EKS cluster.
- You have an IAM OpenID Connect Server created by EKS.
- You have created a IAM role for IRSA testing.

The IAM role should have a *Trust relationship* that looks like this:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/oidc.eks.<AWS_REGION>.amazonaws.com/id/<GUID>"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.<AWS_REGION>.amazonaws.com/id/<GUID>:sub": "system:serviceaccount:test-irsa-ns:test-sa"
        }
      }
    }
  ]
}
```

## Install instructions

- Copy the full ARN for your IRSA test role.
- Open test-irsa.yaml in a text editor and replace <FULL_ARN> with the ARN you copied above.
- Apply test-irsa.yaml to your EKS cluster:

```bash
kubectl apply -f test-irsa.yaml
```

This will create a namespace called *test-irsa* with a pod inside.

## Test instructions

### Get inside the pod

```bash
POD_NAME=$(kubectl get pod -n test-irsa --no-headers -o custom-columns='NAME:.metadata.name')
kubectl --namespace test-irsa exec --stdin --tty $POD_NAME -- /bin/bash
```

### Find your IAM identity

```bash
aws sts get-caller-identity
```

You should then see something like:

```json
{
    "UserId": "ID:IRSA-IRSA",
    "Account": "ACCOUNT_ID",
    "Arn": "arn:aws:sts::ACCOUNT_ID:assumed-role/ROLE_NAME/IRSA-IRSA"
}
```

## Removal instructions

```bash
kubectl delete -f test-irsa.yaml
```
