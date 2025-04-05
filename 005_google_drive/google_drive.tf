# Google Drive APIの有効化
resource "google_project_service" "drive_api" {
  project = var.project_id
  service = "drive.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy        = false
}