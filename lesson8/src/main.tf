resource "yandex_vpc_network" "develop" {
  name = var.vm_db_vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_db_yandex_compute_image
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_platform_name
  platform_id = var.vm_yandex_compute_instance_standart
  resources {
    cores         = var.vm_resources["web"]["cores"]
    memory        = var.vm_resources["web"]["memory"]
    core_fraction = var.vm_resources["web"]["core_fraction"]
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(var.vm_metadata, local.vm_metadata_override)
}

resource "yandex_compute_instance" "db" {
  name        = local.db_platform_name
  platform_id = var.vm_yandex_compute_instance_standart
  resources {
    cores         = var.vm_resources["db"]["cores"]
    memory        = var.vm_resources["db"]["memory"]
    core_fraction = var.vm_resources["db"]["core_fraction"]
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(var.vm_metadata, local.vm_metadata_override)
}