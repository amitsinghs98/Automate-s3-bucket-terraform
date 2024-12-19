terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"   # AWS Provider
      version = "5.54.1"          # Version to use
    }
    random = {
        source = "hashicorp/random"
        version = "3.6.2"
    }
  }
  backend "s3" {                 # Store Terraform state in S3
    bucket = "demo-bucket-amit12345"
    key    = "backend.tfstate"   # File name for state
    region = "eu-north-1"        # AWS region
  }
}

resource "random_id" "rand_id" {
    byte_length = 8
}

provider "aws" {
  region = "eu-north-1"   # AWS Region
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-${random_id.rand_id.hex}"  # Unique bucket name
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.bucket  # Reference the bucket
  source = "./myfile.txt"      # Path to your local file
  key    = "mydata.txt"        # Object name in S3
}
resource "aws_s3_object" "bucket-data1" {
  bucket = aws_s3_bucket.demo-bucket.bucket  # Reference the bucket
  source = "./myfile.txt"      # Path to your local file
  key    = "mydata.txt"        # Object name in S3
}

output "name" {
    value = random_id.rand_id.id
}
