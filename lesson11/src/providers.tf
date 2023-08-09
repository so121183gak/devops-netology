terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
  endpoint = "storage.yandexcloud.net"
  bucket = "tfstate-5"
  region = "ru-central1"
  key = "terraform.tfstate"
  skip_region_validation = true
  skip_credentials_validation = true
  dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gu25rsl7bcn0ehonom/etn3i9g9elhg5kd71meq"
  dynamodb_table = "tfstate-5-table"
}
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}