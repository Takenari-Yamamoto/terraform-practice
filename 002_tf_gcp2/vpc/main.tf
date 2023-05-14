resource "google_compute_network" "vpc" {
  name                    = "my-tf-vpc"
  auto_create_subnetworks = true
}
