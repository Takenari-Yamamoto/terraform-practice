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
