locals {
  nat_platform_name = "${var.vm_yandex_compute_instance_global_name}-${var.vm_web_yandex_compute_instance_platform_name}"
  ssh-keys = "${file("~/.ssh/id_ed25519.pub")}"
}
