@echo off
echo Starting EKS Cluster cleanup...

echo WARNING: This will destroy all resources created by Terraform!
set /p confirm="Are you sure you want to continue? (y/N): "
if /i not "%confirm%"=="y" (
    echo Cleanup cancelled.
    exit /b 1
)

echo Destroying Terraform resources...
terraform destroy -var-file="terraform.tfvars" -auto-approve

echo Cleanup completed!