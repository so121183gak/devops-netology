variable "net_name" {
  type    = string
  default = null
}

variable "subnet_name" {
  type = string
  default = null
}

variable "zone" {
  type = string
}

variable "cidr" {
  type = list(string)
}