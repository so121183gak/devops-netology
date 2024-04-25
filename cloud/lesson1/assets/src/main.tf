# Создаем сеть
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Создаем публичную подсеть
resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr
}

# Создаем приватную подсеть
resource "yandex_vpc_subnet" "private-subnet" {
  name           = "private"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

# Создаем таблицу маршрутизации и статический маршрут
resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "private-into-nat"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image
}

# Создаем ВМ с Nat
resource "yandex_compute_instance" "platform" {
  name        = local.nat_platform_name
  platform_id = var.vm_yandex_compute_instance_standart
  resources {
    cores         = var.vm_resources["nat"]["cores"]
    memory        = var.vm_resources["nat"]["memory"]
    core_fraction = var.vm_resources["nat"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet.id
    ip_address         = "192.168.10.254"
    nat       = true
  }
  metadata = {
    serial-port-enable = var.vm_metadata["serial-port-enable"]
    ssh-keys = "ubuntu:${local.ssh-keys}"

    }
}

# Создаем ВМ Public
resource "yandex_compute_instance" "public" {
  name        = "public"
  platform_id = var.vm_yandex_compute_instance_standart
  resources {
    cores         = var.vm_resources["public"]["cores"]
    memory        = var.vm_resources["public"]["memory"]
    core_fraction = var.vm_resources["public"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public-subnet.id
    nat         = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata["serial-port-enable"]
    ssh-keys = "ubuntu:${local.ssh-keys}"
    }
}

# Создаем ВМ Private
resource "yandex_compute_instance" "vm-private"{
  name        = "private"
  platform_id = var.vm_yandex_compute_instance_standart
  resources {
    cores         = var.vm_resources["private"]["cores"]
    memory        = var.vm_resources["private"]["memory"]
    core_fraction = var.vm_resources["private"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet.id
  }

  metadata = {
    serial-port-enable = var.vm_metadata["serial-port-enable"]
    ssh-keys = "ubuntu:${local.ssh-keys}"

    }
}

# Перекидываем ключи для доступа к приватной ВМ
resource "null_resource" "provision_web" {

  connection {
    host     = yandex_compute_instance.public.network_interface[0].nat_ip_address
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("~/.ssh/id_ed25519")}"
  }

  provisioner "file" {
    source      = "~/.ssh/id_ed25519"
    destination = "/home/ubuntu/.ssh/id_ed25519"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 0600 /home/ubuntu/.ssh/id_ed25519"
    ]
  }

}

