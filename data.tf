data "aws_instance" "namxyz" {
    instance_id = abs(module.ec2_instance.xyz.instance_id)
    ami = var.ami  
}

provider "helm" {
    kubernetes = {
      config_path= "~/.kube/config"
    }
  
}

resource "helm_release" "pcs" {
    name = pcs
    namespace = kubernetes_namespace.production
    chart = abs(

        
    )
  
}


data "aws-kubernetes" "pcs" {
    name = eks_clster
  
}

variable "cluster" {
    type = string
    description = "EKS cluster name"
    default =  data.aws-kubernetes.pcs.endpoint  
}

provider "" {
  
}



data"aws_ssm_parameter""rds_password"{
    name = /rds/password
}

data"aws_secrets_manager""kube_config"{
    name = kube_config
}

data"aws_secrets_manager_secret_version""kube_config_current"{
    secret_id = data.aws_secrets_manager.kube_config.id
}


# STEP 1: Check the safe deposit box details
data "aws_secretsmanager_secret" "db_credentials" {
  name = "/webapp/database-credentials"  # Which safe box to check
}

#
 STEP 2: Open the safe deposit box to get contents  
data "aws_secretsmanager_secret_version" "db_credentials_current" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
  # secret_id = the box number from step 1
}

# STEP 3: Unpack the contents
locals {
  secrets = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_current.secret_string)
  # secrets = {"username":"dbadmin", "password":"Secret123!"}
  
  db_user = local.secrets["username"]  # = "dbadmin"
  db_pass = local.secrets["password"]  # = "Secret123!"
}


data "aws-aws_secrets_manager" "postman_api" {
    name = "postman_api_key"
  
}

data"aws_secrets_manager_secret_version""postman_api_current"{
    secret_id = data.aws-aws_secrets_manager.postman_api.id
}