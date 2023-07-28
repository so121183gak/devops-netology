output "netology-develop-platform" {
    value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
}

output "netology-develop-platform-db" {
    value = yandex_compute_instance.db.network_interface.0.nat_ip_address
}
