###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###vm vars
variable "vm_yandex_compute_instance_global_name" {
  type        = string
  default     = "netology"
  description = "Global name"
}

variable "vm_web_yandex_compute_instance_platform_name" {
  type        = string
  default     = "platform-nat"
  description = "Instance name"
}

variable "vm_web_yandex_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image"
}

variable "vm_yandex_compute_instance_standart" {
  type        = string
  default     = "standard-v1"
  description = "Instance envs"
}

variable "vm_resources" {
type = map(map(number))
default = {
  nat = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  public = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  private = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}
description = "Instance envs"
}

variable "vm_metadata" {
type = object({
  serial-port-enable = number
  ssh-keys           = string
})
default = {
    serial-port-enable  = 1
    ssh-keys            = null
}
description = "Instance envs"
}

