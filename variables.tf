variable "environemnt" {
    description = "value of the environment"
    type = choice
    default = "dev"
    options = ["dev", "staging", "prod"]
  
}

variable "rds_username" {
    description = "RDS database username"
    type = string
    default = "adminuser"
  
}

variable "ami" {
    type = string
    description = "The AMI ID for the EC2 instance"
  
}

provider "aws" {
    region = var.environemnt
    
  
}

backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "path/to/terraform.tfstate"
    region = "us-west-2"
    locks_table = "terraform-locks"
}




terraform {
    required-providers {
        aws = {
            source = "hashicorp/aws"
            version = ">=4.3"
        }
        helm = {
            kubernetes = {
                config_path= var.kube_config_path
                version = ">=2.7"
            }
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = ">=2.7"
        }
        rancher2 = {
            source = "rancher/rancher2"
            version = ">=1.20"
        }
        mongodb = {
            source = ""
        }
    }
}


variable "api_key" {
    tyoe = string
    sensitive = true

  
}