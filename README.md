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
