# GCP provider

provider "google" {
  credentials = file(var.gcp_service_act_key)
  project = var.gcp_project
  region = var.gcp_region
}
