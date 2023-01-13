terraform {
  backend "gcs" {
    bucket = "62a84aa27a0398dd-bucket-tfstate"
    prefix = "terraform/state"
  }
}