terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}

provider "google-beta" {
  billing_project       = "golang-project-377611"
  user_project_override = true
  region                = "asia-northeast1"
}

# Firebase プロジェクト用の GCP プロジェクトを立ち上げる
resource "google_project" "default" {
  provider = google-beta

  # project_id は全世界で一意になる必要がある
  project_id      = "fire-tf-23424"
  name            = "fire-tf-project"
  billing_account = "015328-944178-048110"

  # Firebase のプロジェクトとして表示するために必要
  labels = {
    "firebase" = "enabled"
  }
}

# Firebase のプロジェクトを立ち上げる
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = google_project.default.project_id

  depends_on = [
    google_project_service.default,
  ]
}

# Firebase プロジェクトが作られてから60秒待つ
resource "time_sleep" "wait_60_seconds" {
  depends_on = [google_project.default]

  create_duration = "60s"
}

# 各種APIを有効化する
resource "google_project_service" "default" {
  provider = google-beta
  project  = google_project.default.project_id
  for_each = toset([
    "cloudbuild.googleapis.com",
    "firestore.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "identitytoolkit.googleapis.com",
  ])
  service = each.key

  disable_on_destroy = false
  depends_on         = [time_sleep.wait_60_seconds]
}

# Firebase Authentication を有効化する
resource "google_identity_platform_config" "default" {
  provider = google-beta
  project  = google_project.default.project_id

  depends_on = [
    google_project_service.default,
  ]
}

# メール/パスワード認証 を有効にする
resource "google_identity_platform_project_default_config" "default" {
  provider = google-beta
  project  = google_project.default.project_id
  sign_in {
    allow_duplicate_emails = false

    email {
      enabled           = true
      password_required = true
    }
  }

  # email/password の認証を有効化する前に Firebase Authentication が有効化されるのを待つ
  depends_on = [
    google_identity_platform_config.default
  ]
}

resource "google_app_engine_application" "firebase" {
  provider      = google-beta
  project       = google_project.default.project_id
  location_id   = "asia-northeast1"
  database_type = "CLOUD_FIRESTORE"
}

resource "google_firebase_web_app" "default" {
  provider        = google-beta
  project         = google_project.default.project_id
  display_name    = "web_app"
  deletion_policy = "DELETE"

  depends_on = [google_firebase_project.default]
}

data "google_firebase_web_app_config" "default" {
  provider   = google-beta
  web_app_id = google_firebase_web_app.default.app_id
  project    = google_firebase_project.default.project
}

output "firebase_project_id" {
  value = google_project.default.project_id
}

output "firebase_web_app_api_key" {
  value = data.google_firebase_web_app_config.default.api_key
}

output "firebase_web_app_auth_domain" {
  value = data.google_firebase_web_app_config.default.auth_domain
}

output "firebase_web_app_id" {
  value = data.google_firebase_web_app_config.default.web_app_id
}

output "firebase_web_app_messaging_sender_id" {
  value = data.google_firebase_web_app_config.default.messaging_sender_id
}

output "firebase_web_app_storage_bucket" {
  value = data.google_firebase_web_app_config.default.storage_bucket
}
