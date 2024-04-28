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

# Создаем сетевой балансировщик
resource "yandex_lb_network_load_balancer" "lb" {
  name = "network-lb"

  listener {
    name = "lb-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
  depends_on = [
    yandex_compute_instance_group.lamp
]
}

# Создаем группу виртуальных машин
resource "yandex_compute_instance_group" "lamp" {
  name                = "vm-lamp"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.sa-ig.id}"
  deletion_protection = false
  instance_template {
    platform_id = var.vm_yandex_compute_instance_standart
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.develop.id}"
      subnet_ids = ["${yandex_vpc_subnet.public-subnet.id}"]
      nat        = "true"
    }
    metadata = {
      user-data          = data.template_file.cloudinit.rendered
  }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["${var.default_zone}"]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 1
  }

  health_check {
    http_options {
      port = 80
      path = "/index.html"
    }
  }

  depends_on = [yandex_storage_bucket.test-bucket]

  load_balancer {
    target_group_name        = "vm-lamp"
    target_group_description = "test balancer"
  }
}

# Используя файл шаблона Cloudinit размещаем картинку
data "template_file" "cloudinit" {
 template = file("${path.module}/cloud-init.yml")
 vars = {
   ssh_public_key = local.ssh-keys
   image_id = var.image_id
 }
}



