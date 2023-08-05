output "net_id" {
    value = yandex_vpc_network.net.id
}

output "subnet_id" {
    value = yandex_vpc_subnet.subnet.id
}

output "subnet_zone" {
    value = yandex_vpc_subnet.subnet.zone
}