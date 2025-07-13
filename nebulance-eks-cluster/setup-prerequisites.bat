@echo off
echo Setting up prerequisites for EKS deployment...

echo Creating S3 bucket for Terraform state...
aws s3 mb s3://nebulance-terraform-state-bucket --region eu-central-1

echo Enabling versioning on S3 bucket...
aws s3api put-bucket-versioning --bucket nebulance-terraform-state-bucket --versioning-configuration Status=Enabled

echo Creating DynamoDB table for state locking...
aws dynamodb create-table ^
    --table-name terraform-locks ^
    --attribute-definitions AttributeName=LockID,AttributeType=S ^
    --key-schema AttributeName=LockID,KeyType=HASH ^
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 ^
    --region eu-central-1

echo Prerequisites setup completed!
echo Now uncomment the backend block in backend.tf and run terraform init again