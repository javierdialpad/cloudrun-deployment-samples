variable "project" {
  type        = string
  description = "Project ID"
  default     = "smart-envoy-270916"
}

variable "region" {
  type        = string
  description = "Project region"
  default     = "us-central1"
}

variable "gh_owner" {
  type        = string
  description = "GitHub repo owner"
  default     = "javierdialpad"
}

variable "gh_repo" {
  type        = string
  description = "GitHub repo name"
  default     = "cloudrun-deployment-samples"
}
