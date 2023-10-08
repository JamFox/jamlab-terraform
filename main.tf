module "infra" {
  source = "./modules/vm_qemu"

  connection_type             = var.connection_type
  connection_user             = var.connection_user
  connection_host             = var.connection_host
  connection_private_key_path = var.connection_private_key_path

  vms = {
    # BEGIN: Virtual Nomad Base Nodes
    "vb0" = {
      ipconfig0 = "ip=192.168.10.120/16,gw=192.168.10.1"
      hostname  = "vb0"
      fqdn      = "vb0.jamfox.dev"
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
      desc    = "Virtual Nomad Base Node"
      memory  = 12288
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "150G"
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
    }, # End: vb0
    "vb1" = {
      ipconfig0 = "ip=192.168.10.121/16,gw=192.168.10.1"
      hostname  = "vb1"
      fqdn      = "vb1.jamfox.dev"
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
      desc    = "Virtual Nomad Base Node"
      memory  = 12288
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "150G"
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
    }, # End: vb1
    "vb2" = {
      ipconfig0 = "ip=192.168.10.122/16,gw=192.168.10.1"
      hostname  = "vb2"
      fqdn      = "vb2.jamfox.dev"
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
      desc    = "Virtual Nomad Base Node"
      memory  = 12288
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "150G"
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
    }, # End: vb2
    # BEGIN: Virtual Nomad Service Nodes
    "vs0" = {
      ipconfig0 = "ip=192.168.10.130/16,gw=192.168.10.1"
      hostname  = "vs0"
      fqdn      = "vs0.jamfox.dev"
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
      desc    = "Virtual Nomad Service Node"
      memory  = 12288
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "150G"
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
    }, # End: vs0
    "vs1" = {
      ipconfig0 = "ip=192.168.10.131/16,gw=192.168.10.1"
      hostname  = "vs1"
      fqdn      = "vs1.jamfox.dev"
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
      desc    = "Virtual Nomad Service Node"
      memory  = 12288
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "150G"
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
    }, # End: vs1
    "vs2" = {
      ipconfig0 = "ip=192.168.10.132/16,gw=192.168.10.1"
      hostname  = "vs2"
      fqdn      = "vs2.jamfox.dev"
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
      desc    = "Virtual Nomad Service Node"
      memory  = 12288
      sockets = 2
      cores   = 2
      disks = [
        {
          size     = "150G"
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
    }, # End: vs2
  }    # End: vms
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
