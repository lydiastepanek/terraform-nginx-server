terraform {
  backend "s3" {
    encrypt = true
    bucket  = "my-tf-state-storage"
    region  = "us-east-1"
    key     = "state"
    profile = "home"
  }
}
