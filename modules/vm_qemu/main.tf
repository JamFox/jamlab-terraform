resource "local_file" "cloud_init_user_data_file" {
  for_each = var.vms

  filename = "${path.module}/files/vm-${each.key}-cloud-init.yaml"
  content  = <<EOF
#cloud-config
hostname: ${each.value.hostname}
manage_etc_hosts: ${each.value.manage_etc_hosts}
fqdn: ${each.value.fqdn}
timezone: ${each.value.timezone}
users:
  - name: ${each.value.username}
    ssh-authorized-keys:
    ${join("\n", ["  - ${join("\n      - ", each.value.ssh_authorized_keys)}"])}
    sudo: ${each.value.sudo_config}
    groups: sudo
    shell: /bin/bash
package_upgrade: ${each.value.package_upgrade}
${length(each.value.packages) > 0 ? "packages:\n${join("\n", [for pkg in each.value.packages : "  - ${pkg}"])}" : ""}
${length(each.value.runcmd) > 0 ? "runcmd:\n${join("\n", [for cmd in each.value.runcmd : "  - ${cmd}"])}" : ""}
EOF  
}

resource "null_resource" "cloud_init_config_files" {
  for_each = var.vms

  connection {
    type        = var.connection_type
    user        = var.connection_user
    host        = var.connection_host
    private_key = file(var.connection_private_key_path)
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_file[each.key].filename
    destination = "${var.provisioner_directory_path}/vm-${each.key}-cloud-init.yaml"
  }
}

resource "proxmox_vm_qemu" "vms" {
  for_each = var.vms

  target_node = each.value.target_node
  #vmid        = each.value.vmid
  name       = each.key
  clone      = each.value.clone
  full_clone = each.value.full_clone
  qemu_os    = each.value.qemu_os
  pool       = each.value.pool
  desc       = each.value.desc

  memory  = each.value.memory
  numa    = each.value.numa
  sockets = each.value.sockets
  cores   = each.value.cores
  cpu     = each.value.cpu
  scsihw  = each.value.scsihw

  onboot   = each.value.onboot
  os_type  = each.value.os_type
  bootdisk = each.value.bootdisk
  hotplug  = each.value.hotplug
  agent    = each.value.agent
  lifecycle {
    ignore_changes = [disk, sockets, cores, cpu, scsihw, onboot, bootdisk, hotplug]
  }
  vga {
    type = each.value.vga_type
    # Between 4 and 512, ignored if type is defined to serial
    memory = each.value.vga_memory
  }

  dynamic "disk" {
    for_each = each.value.disks
    content {
      type     = disk.value.type
      storage  = disk.value.storage
      size     = disk.value.size
      iothread = disk.value.iothread
      ssd      = disk.value.ssd
      #backup   = disk.value.backup
    }
  }

  dynamic "network" {
    for_each = each.value.networks
    content {
      model    = network.value.model
      bridge   = network.value.bridge
      tag      = network.value.tag
      firewall = network.value.firewall
    }
  }

  # Cloud-Init
  ipconfig0 = each.value.ipconfig0
  ipconfig1 = each.value.ipconfig1
  ipconfig2 = each.value.ipconfig2
  ipconfig3 = each.value.ipconfig3
  ipconfig4 = each.value.ipconfig4
  ipconfig5 = each.value.ipconfig5
  # ipconfig6-15 are supported in later versions of Proxmox provider
  # we are using an older version of the provider
  #ipconfig6  = each.value.ipconfig6
  #ipconfig7  = each.value.ipconfig7
  #ipconfig8  = each.value.ipconfig8
  #ipconfig9  = each.value.ipconfig9
  #ipconfig10 = each.value.ipconfig10
  #ipconfig11 = each.value.ipconfig11
  #ipconfig12 = each.value.ipconfig12
  #ipconfig13 = each.value.ipconfig13
  #ipconfig14 = each.value.ipconfig14
  #ipconfig15 = each.value.ipconfig15
  cicustom = "user=${each.value.cicustom_volume}:snippets/vm-${each.key}-cloud-init.yaml"
}
