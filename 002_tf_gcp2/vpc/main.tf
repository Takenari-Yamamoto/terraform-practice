resource "google_compute_network" "vpc" {
  name                    = "my-tf-vpc"
  project                 = var.project_id
  auto_create_subnetworks = false
}
