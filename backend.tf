locals {
    common_labels {
        env = "dev"
    }
}
#when we have multiple resource block, so we define local, and add local in resource block to inherit the property, defined in local.

backend "gcs" {
    bucket = "state-file-store"
    prefix = "terraform/state"
    labels = local.common_labels
  }