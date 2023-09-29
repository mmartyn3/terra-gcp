# Note - the GCP provider syntax is set in providers.tf file

# create cloud storage bucket to store static website
resource "google_storage_bucket" "static_website_bucket" {
  provider = google # not technically required if only have 1 provider in providers.tf file
  name = "terraform-bucket" # CHANGE THIS - the bucket name needs to be globally unique in GCP
  location = "US"
}

# make object public
resource "google_storage_object_access_control" "public_rule" {
  object = google_storage_bucket_object.static_site_html.name
  bucket = google_storage_bucket.static_website_bucket.name
  role = "READER"
  entity = "allUsers"
}

# upload index.html to bucket
resource "google_storage_bucket_object" "static_site_html" {
  provider = google # not technically required if only have 1 provider in providers.tf file
  name = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.static_website_bucket.name
}
