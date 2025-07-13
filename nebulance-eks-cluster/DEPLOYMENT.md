# EKS Cluster Deployment Guide

## Prerequisites

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** installed (version >= 1.0)
3. **kubectl** installed for cluster management

## Step-by-Step Deployment

### 1. Setup AWS Prerequisites
```bash
# Run the prerequisites setup script
setup-prerequisites.bat
```

### 2. Configure Backend (After Prerequisites)
- Uncomment the backend block in `backend.tf`
- Run `terraform init` again to migrate state to S3

### 3. Deploy EKS Cluster
```bash
# Run the deployment script
deploy.bat
```

### 4. Configure kubectl
```bash
aws eks update-kubeconfig --region eu-central-1 --name eks-nebulance
```

### 5. Verify Deployment
```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

## Configuration Files

- `main.tf` - Main infrastructure configuration
- `provider.tf` - AWS provider configuration
- `backend.tf` - Terraform backend configuration
- `variables.tf` - Variable definitions
- `terraform.tfvars` - Variable values
- `outputs.tf` - Output definitions

## Cleanup

To destroy all resources:
```bash
cleanup.bat
```

## Troubleshooting

1. **Authentication Issues**: Ensure AWS CLI is configured with proper credentials
2. **Region Issues**: Verify the region in terraform.tfvars matches your AWS CLI default region
3. **State Lock Issues**: Check DynamoDB table exists and is accessible

## Resources Created

- VPC with public/private subnets
- EKS Cluster (version 1.28)
- EKS Managed Node Group (2 t3.medium instances)
- NAT Gateway for private subnet internet access
- Required IAM roles and security groups