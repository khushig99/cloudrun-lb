resource "google_cloud_run_service" "app" {
  name     = "demo-app"
  location = var.region
 
  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }
 
  traffic {
    percent         = 100
    latest_revision = true
  }
}
