resource "google_storage_bucket" "remotebkt" {
    name = "state-file-store"
    location = var.region
}