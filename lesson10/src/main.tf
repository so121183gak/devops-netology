
### Этот закоментированный блок кода необходим для выполнения Задания 1
/*resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}*/

module "vpc_dev" {
  source       = "./vpc_dev"
  net_name     = "testing"
  subnet_name  = "test1"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_dev.net_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.vpc_dev.subnet_id ]
  instance_name   = "web"
  instance_count  = 1
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }

}


data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
 vars = {
   ssh_public_key = file("~/.ssh/id_ed25519.pub")
 }
}
