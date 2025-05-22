provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "docker_repo" {
  provider = google
  location     = var.region
  repository_id = "flask-app-repo"
  format       = "DOCKER"
}

resource "google_cloud_run_service" "flask_app" {
  name     = "flask-task-app"
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

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_member" "noauth" {
  location        = google_cloud_run_service.flask_app.location
  service         = google_cloud_run_service.flask_app.name
  role            = "roles/run.invoker"
  member          = "allUsers"
}
