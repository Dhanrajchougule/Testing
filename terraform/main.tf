terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "flask_repo" {
  location      = var.region
  repository_id = var.repo_name
  format        = "DOCKER"
}

resource "google_cloud_run_service" "flask_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image_url
        ports {
          container_port = 8080
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.flask_service.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}
