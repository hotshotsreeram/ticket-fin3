terraform {
  backend "s3" {
#cannot use variables in backend.tf
    bucket = "my-tf-sr-first-bucket"
    key    = "eks/terraform.state"
    region = "us-east-1"
  }
}
