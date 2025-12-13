resource "kubernetes_secret" "secret" {
    depends_on = [ rancher2_namespace.bds ]
    metadata {
        name      = "bds-secret"
        namespace = rancher2_namespace.bds.name
    }
    data = {
        rancher_api_key = jsondecode((data.aws_secretsmanager_secret_version.rancher_apikey.secret_string))["rancher_api_key"]
    }
  
}

data "aws_secretsmanager" "db_passowrd" {
    name = "db_passowrd"
  
}

data "aws_secretsmanager_secret_version" "db_passowrd" {
    secret_id = data.aws_instance.namxyz
  
}

db_passowrd = var.password

terraform {
  backend "s3" {
    
  }
}

backend "s3" {
    bucket
    key
    encrypt
    use_lockfile
}

