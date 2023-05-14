resource "google_vpc_access_connector" "default" {
  name          = var.vpc_connector_name
  region        = var.region
  network       = var.network_name
  ip_cidr_range = var.ip_cidr_range
}

data "google_iam_policy" "no_auth" {
  binding {
    role = "roles/run.invoker"

    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-svc"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}

resource "google_cloud_run_service_iam_policy" "public" {
  location    = google_cloud_run_service.default.location
  project     = var.project_id
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.no_auth.policy_data
}
