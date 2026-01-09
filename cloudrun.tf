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
 #Defines the container image to run—Google’s public sample container.

  traffic {
    percent         = 100
    latest_revision = true
  }
}

#If you want public access through the load balancer, Cloud Run typically needs invoker access for unauthenticated requests. You can either:
#Allow unauthenticated directly on Cloud Run, or
#Use Cloud Armor/Identity-Aware Proxy or signed URL setups.
