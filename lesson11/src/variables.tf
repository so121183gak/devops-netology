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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}

variable "test_ip" {
  type        = string
  default     = "192.168.0.1"
  description = "ip-адрес"
  validation {
    condition = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.test_ip))
    error_message = "Invalip IP adres"
  }
}

variable "test_list_ip" {
  type        = list(string)
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  description = "список ip-адресов"
  validation {
    condition = can([for ip in var.test_list_ip : regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", ip)])
    error_message = "Invalip IP adres"
  }
}


