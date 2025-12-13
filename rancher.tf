terraform {
  required_providers {
    rancher2 = 
    source = "rancher/rancher2"
    version = ">=1.20"
  }
}

provider "rancher2" {
  api_url   = "https://rancher.example.com/v3"
  access_key = var.access_key
  secret_key = var.secret_key
  token_key  = var.token_key
}

resource "rancher2_namespace" "bds" {
    name        = "bds-namespace"
    description = "Namespace for BDS applications"

    labels {
        environment = var.environment
        "autocleanup/exclude" = "true"
    }
    
    resource_quota {
        limit {
            limit_cpu    = "4"
            limit_memory = "8Gi"
            pods        = "10"
            pvc         = "5"
        }

        container_resource_limit {
            limits
        }
        


}

