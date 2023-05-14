terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.78.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  credentials = file(var.credentials)
  region      = var.region
  zone        = var.zone
}

module "vpc" {
  source     = "./vpc"
  project_id = var.project_id
}

module "cloud_sql" {
  source            = "./cloud_sql"
  project_id        = var.project_id
  region            = var.region
  network_self_link = module.vpc.network_self_link
}

module "cloud_run" {
  source             = "./cloud_run"
  project_id         = var.project_id
  region             = var.region
  network_name       = module.vpc.network_name
  vpc_connector_name = "my-vpc-connector"
  ip_cidr_range      = "10.8.0.0/28"
}
