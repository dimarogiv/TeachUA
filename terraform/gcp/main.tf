terraform {
  backend "gcs" {
    bucket = "teachua-tfstate"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "google" {
  project = var.project_name
  region  = var.google_region_name
  zone    = var.google_zone_name
}

# GCP
module "gcp_meta" {
  source       = "./modules/meta"
  count        = var.cloud_platform == "gcp" ? 1 : 0
  project_name = var.project_name
}

module "gcp_network" {
  source             = "./modules/network"
  count              = var.cloud_platform == "gcp" ? 1 : 0
  google_region_name = var.google_region_name
}

module "gcp_instances" {
  source           = "./modules/instances"
  count            = var.cloud_platform == "gcp" ? 1 : 0
  compute_network  = module.gcp_network[0].compute_network
  back_subnetwork  = module.gcp_network[0].back_subnetwork
  google_zone_name = var.google_zone_name
}

module "gcp_database" {
  source      = "./modules/database"
  count       = var.cloud_platform == "gcp" ? 1 : 0
  region      = var.google_region_name
  backend_ip  = module.gcp_instances[0].backend_ip
  db_password = var.db_password
  db_user     = var.db_user
}

module "gcp_firewall" {
  source          = "./modules/firewall"
  count           = var.cloud_platform == "gcp" ? 1 : 0
  compute_network = module.gcp_network[0].compute_network
}

module "gcp_local_provision" {
  source           = "./modules/local_provision"
  count            = var.cloud_platform == "gcp" ? 1 : 0
  bastion          = module.gcp_instances[0].bastion
  google_zone_name = var.google_zone_name
}
