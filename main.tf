resource "hcloud_ssh_key" "main" {
  name       = "sodacity-ssh-public-key"
  public_key = var.vm_ssh_key
}

resource "hcloud_server" "server" {
  count = var.hcloud_num_vms

  name        = "${var.org_name}-${var.hcloud_location}-vm-${count.index}"
  server_type = "cpx11"
  location    = var.hcloud_location
  image       = "ubuntu-24.04"

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  user_data = templatefile("${path.module}/cloudinit.yml.tftpl", {
    ssh_public_key = var.vm_ssh_key
  })
  ssh_keys = [hcloud_ssh_key.main.id]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ssh_keys]
  }
}
