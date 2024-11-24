output "hcloud_vm_ipv4s" {
    value = hcloud_server.server[*].ipv4_address
}
