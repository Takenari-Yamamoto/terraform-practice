resource "google_compute_network" "vpc" {
  name                    = "my-tf-vpc"
  project                 = "golang-project-377611"
  auto_create_subnetworks = false
}
