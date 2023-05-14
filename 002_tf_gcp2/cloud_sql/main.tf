resource "google_sql_database_instance" "default" {
  name             = "my-db-instance"
  project          = var.project_id
  region           = var.region
  database_version = "POSTGRES_12"
  depends_on       = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_self_link
    }
  }
}

resource "google_sql_database" "default" {
  name     = "my-database"
  instance = google_sql_database_instance.default.name
  project  = var.project_id
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

output "instance_connection_name" {
  value = google_sql_database_instance.default.connection_name
}
