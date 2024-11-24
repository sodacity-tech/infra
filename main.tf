resource "hcloud_ssh_key" "main" {
  name       = "sodacity-ssh-public-key"
  public_key = var.vm_ssh_key
}

resource "random_pet" "hcloud_vm_names" {
  count = var.hcloud_num_vms

  prefix = "${var.org_name}-${var.hcloud_location}-vm"
}

resource "hcloud_server" "server" {
  count = var.hcloud_num_vms

  name        = random_pet.hcloud_vm_names[count.index].id
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
    ignore_changes = [ssh_keys]
  }
}
