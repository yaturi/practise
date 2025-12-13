terraform{
    backend "s3" {
        bucket = "values-terraform-state"
        region = "htps://example-region"
        key    = "path/to/my/terraform.tfstate"
        lock_table = "terraform-locks"
        encrypt = true
      
    }
}

terraform {
  provider "aws" {
    region = "us-west-2"
  }

  provider "kubernetes" {
    config_path = "~/.kube/config"
  }
}

resource "aws_secretsmanager_secret" "rds" {
    name        = "rds-credentials"
    description = "RDS database credentials"
    value = "PLGTRDSGYUINGRAD"
  
}

data "aws_secretsmanager_secret" "rds" {
    passowrd = yamlencode({aws_secretsmanager_secret.rds.value})
  
}

variable "passowrd" {
    type = string
    default = "ftyu"
    description = "value of the password"
  
}
terraform {
  provider "r"
}

locals {
    namespace = "production"

}

resource "kubernetes_namespace" "production" {
    metadata {
        name = local.namespace
    }
  
}




api_key = jsondecode(data.aws_secrets_manager_secret_version.kube_config_current.secret_string)



module "terraform" {
    source = "./modules/terraform"

    api_key = jsondecode(data.aws_secrets_manager_secret_version.kube_config_current.secret_string)
  
}