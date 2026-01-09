resource "google_compute_backend_service" "backend" {
  name     = "cloudrun-backend"
  protocol = "HTTP"
 
  backend {
    group = google_compute_region_network_endpoint_group.serverless_neg.id
  }
}
#Defines a backend service that the load balancer will route to
#protocol = "HTTP": Since Cloud Run is HTTP-based.
#connecting neg as backend group
 
resource "google_compute_url_map" "url_map" {
  name            = "cloudrun-map"
  default_service = google_compute_backend_service.backend.id
}
#url map to route incoming traffic
#default_service: All paths go to the Cloud Run backend
 
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "cloudrun-proxy"
  url_map = google_compute_url_map.url_map.id
}
#HTTP proxy that binds the URL map to the load balancer

resource "google_compute_global_forwarding_rule" "http_rule" {
  name       = "cloudrun-http-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
#Global forwarding rule listening on port 80
#Sends traffic to the HTTP proxy → URL map → backend service → Cloud Run.