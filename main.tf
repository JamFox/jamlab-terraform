module "infra" {
  source = "./modules/vm_qemu"

  connection_type             = var.connection_type
  connection_user             = var.connection_user
  connection_host             = var.connection_host
  connection_private_key_path = var.connection_private_key_path

  vms = {
  } # End: vms
}

module "sandbox" {
  source = "./modules/vm_qemu"

  connection_type             = var.connection_type
  connection_user             = var.connection_user
  connection_host             = var.connection_host
  connection_private_key_path = var.connection_private_key_path

  vms = {
    "logmon" = {
      ipconfig0 = "ip=192.168.10.50/16,gw=192.168.10.1"
      hostname  = "logmon"
      fqdn      = "logmon.jamfox.dev"
      username  = "ubuntu"
      ssh_authorized_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILayJ7ZP6Z6IDms4ujnz9nRnAJEIXwyto1SbSwfzjqst jamfox"
      ]
      sudo_config = "['ALL=(ALL) NOPASSWD:ALL']"
      runcmd = [
        "sudo apt update && sudo apt upgrade -y",
        "sudo /usr/sbin/reboot"
      ]
      # VMS
      clone   = "ubuntu22"
      desc    = "Logging and monitoring lab machine"
      memory  = 8192
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "50G"
          iothread = 1
          ssd      = 0
        }
      ]
      networks = [
        {
          bridge   = "vmbr0"
          firewall = false
        }
      ]
    }, # End: logmon
  }    # End: vms
}
