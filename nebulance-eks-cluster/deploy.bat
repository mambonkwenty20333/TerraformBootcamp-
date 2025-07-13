@echo off
echo Starting EKS Cluster Deployment...

echo Step 1: Initialize Terraform
terraform init

echo Step 2: Validate configuration
terraform validate

echo Step 3: Plan deployment
terraform plan -var-file="terraform.tfvars"

echo Step 4: Apply configuration (requires confirmation)
terraform apply -var-file="terraform.tfvars"

echo Deployment completed!
echo Run 'aws eks update-kubeconfig --region eu-central-1 --name eks-nebulance' to configure kubectl