output "network_self_link" {
  description = "The URI of the VPC being created"
  value       = google_compute_network.vpc.self_link
}

output "network_name" {
  value = google_compute_network.vpc.name
}
