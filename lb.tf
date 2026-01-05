resource "google_compute_backend_service" "backend" {
  name     = "cloudrun-backend"
  protocol = "HTTP"
 
  backend {
    group = google_compute_region_network_endpoint_group.serverless_neg.id
  }
}
 
resource "google_compute_url_map" "url_map" {
  name            = "cloudrun-map"
  default_service = google_compute_backend_service.backend.id
}
 
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "cloudrun-proxy"
  url_map = google_compute_url_map.url_map.id
}
 
resource "google_compute_global_forwarding_rule" "http_rule" {
  name       = "cloudrun-http-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
