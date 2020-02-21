terraform {
  required_version = "~> 0.12"
  required_providers {
    aws = "~> 2"
  }
}

provider "aws" {
  region = "us-east-1"
}
