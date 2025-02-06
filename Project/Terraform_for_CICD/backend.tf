terraform {
  backend "s3" {
    bucket         = "ajay-shakapuram-tf-ap-south"  # Replace with your S3 bucket name
    key            = "cicd/terraform.tfstate"       # Path inside the bucket
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"         # State lock table
    encrypt        = true
  }
}
