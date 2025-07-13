terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Comment out the backend block for initial setup
  # Uncomment after creating the S3 bucket and DynamoDB table
  /*
  backend "s3" {
    bucket         = "nebulance-terraform-state-bucket"
    key            = "eks/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
  */
}