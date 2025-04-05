resource "google_service_account" "drive_manager" {
  account_id   = "google-drive-manager"
  display_name = "Google Drive Manager"
  description  = "Service account for managing Google Drive operations"
}