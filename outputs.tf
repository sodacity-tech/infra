output "hcloud_vm_ipv4s" {
  value = sort(hcloud_server.server[*].ipv4_address)
}
