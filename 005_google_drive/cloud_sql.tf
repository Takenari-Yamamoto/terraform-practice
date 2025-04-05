resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"  # 最小スペック（開発環境向け）

    backup_configuration {
      enabled = true
      binary_log_enabled = true
    }

    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
    }
  }

  deletion_protection = false  # 開発環境用にfalseに設定。本番環境ではtrueにすることを推奨
}

resource "google_sql_database" "database" {
  name     = "myapp"
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "users" {
  name     = "myapp-user"
  instance = google_sql_database_instance.main.name
  password = "changeme123"  # 本番環境では必ず変更してください
}