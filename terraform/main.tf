provider "google" {
  project = var.project
  region  = var.region
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_project_service" "run_api" {
  service = "run.googleapis.com"
  project = var.project
}

resource "google_cloud_run_service" "default" {
  name     = "gh-terraform"
  location = var.region

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }
}
