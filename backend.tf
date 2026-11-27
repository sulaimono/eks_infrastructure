terraform {
  backend "s3" {
    bucket       = "slyy-tata-bck-remote"
    key          = "3tier-infra/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}
