resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "cloudrun-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
 
  cloud_run {
    service = google_cloud_run_service.app.name
  }
}
#network_endpoint_type = "SERVERLESS" is required for Cloud Run/IAP/Cloud Functions routing.
#Binds the NEG to the Cloud Run service created earlier (demo-app).
