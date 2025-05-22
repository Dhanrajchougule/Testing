variable "project_id" {
  description = "Your GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "repo_name" {
  description = "Artifact Registry repository name"
  type        = string
  default     = "flask-repo"
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "flask-task-app"
}

variable "image_url" {
  description = "Full Docker image URL in Artifact Registry"
  type        = string
}
