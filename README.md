# Self-Managed EKS Node Group

This repository contains Terraform configurations to create an Amazon EKS cluster with self-managed node groups. Self-managed nodes give you greater control over your EC2 instances compared to managed node groups, which are fully managed by AWS.

## Usage

To provision the EKS cluster and associated resources using Terraform, follow these steps:

### 1. Initialize Terraform

terraform init

 ### 2. Review the exectution plan

terraform plan

### 3. Apply the configuration

terraform apply --auto-approve

### 4. IMPORTANT!!! Clean Up Resources

terraform destroy --auto-approve

### 4. We can also create the EKS cluster with eksctl command line:
Make sure eksctl is configured to have access to the AWS account

eksctl create cluster \
--name  oncourse-cluster \
--version 1.30 \
--region us-east-1 \
--nodegroup-name oncourse-cluster-workers \
--node-type t3.large \
--nodes 1 \
--nodes-min 1 \
--nodes-max 2 \
--managed
