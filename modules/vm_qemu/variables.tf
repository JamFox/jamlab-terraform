# Provisioner Cloud-Init File
variable "connection_type" {
  type        = string
  description = "The connection type. Valid values are `ssh` and `winrm`. Provisioners typically assume that the remote system runs Microsoft Windows when using WinRM. Behaviors based on the SSH target_platform will force Windows-specific behavior for WinRM, unless otherwise specified."
}

variable "connection_user" {
  type        = string
  description = "The user to use for the connection."
}

variable "connection_private_key_path" {
  type        = string
  description = "The contents of an SSH key to use for the connection. These can be loaded from a file on disk using the file function. This takes preference over password if provided."
}

variable "connection_host" {
  type        = string
  description = "The address of the pve host to connect to."
}

variable "provisioner_directory_path" {
  type        = string
  description = "The directory path (without the filename) used by the provisioner."
  default     = "/var/lib/vz/snippets"
}


variable "vms" {
  description = "Map of virtual machines to create"
  type = map(object({
    ipconfig0 = string
    ipconfig1 = optional(string, "")
    ipconfig2 = optional(string, "")
    ipconfig3 = optional(string, "")
    ipconfig4 = optional(string, "")
    ipconfig5 = optional(string, "")
    # ipconfig6-15 are supported in later versions of Proxmox provider
    # we are using an older version of the provider
    #ipconfig6           = optional(string, "")
    #ipconfig7           = optional(string, "")
    #ipconfig8           = optional(string, "")
    #ipconfig9           = optional(string, "")
    #ipconfig10          = optional(string, "")
    #ipconfig11          = optional(string, "")
    #ipconfig12          = optional(string, "")
    #ipconfig13          = optional(string, "")
    #ipconfig14          = optional(string, "")
    #ipconfig15          = optional(string, "")
    cicustom_volume     = optional(string, "local")
    hostname            = string
    manage_etc_hosts    = optional(bool, true)
    fqdn                = string
    timezone            = optional(string, "Europe/London")
    username            = string
    ssh_authorized_keys = list(string)
    sudo_config         = string
    package_upgrade     = optional(bool, false)
    packages            = optional(list(string), [])
    runcmd              = list(string)
    target_node         = optional(string, "pve0")
    clone               = string
    full_clone          = optional(bool, true)
    qemu_os             = optional(string, "l26")
    pool                = optional(string, "")
    desc                = string
    memory              = number
    numa                = optional(bool, false)
    sockets             = number
    cores               = number
    cpu                 = optional(string, "host")
    scsihw              = optional(string, "virtio-scsi-single")
    onboot              = optional(bool, true)
    os_type             = optional(string, "cloud-init")
    bootdisk            = optional(string, "scsi0")
    hotplug             = optional(string, "network,disk,usb")
    agent               = optional(number, 1)
    vga_type            = optional(string, "std")
    vga_memory          = optional(number, 128)
    disks = list(object({
      type     = optional(string, "scsi")
      storage  = optional(string, "local-lvm")
      size     = string
      iothread = number
      ssd      = number
      backup   = optional(bool, false)
    }))
    networks = list(object({
      model    = optional(string, "virtio")
      bridge   = string
      firewall = bool
      tag      = optional(number, -1)
    }))
  }))

  default = {
    example_vm = {
      # Cloud-Init
      target_node         = "pve"
      ipconfig0           = "ip=192.168.1.10/24,gw=192.168.1.1,ip6=dhcp"
      cicustom_volume     = "local"
      hostname            = "example"
      manage_etc_hosts    = true
      fqdn                = "example.com"
      timezone            = "UTC"
      username            = "exampleuser"
      ssh_authorized_keys = []
      sudo_config         = ""
      package_upgrade     = false
      packages            = []
      runcmd              = []
      # VMS
      target_node = "pve"
      vmid        = 0
      clone       = "template"
      full_clone  = true
      qemu_os     = "l26"
      pool        = "default"
      desc        = ""
      memory      = 2048
      numa        = false
      sockets     = 1
      cores       = 2
      cpu         = "host"
      scsihw      = "virtio-scsi-single"
      onboot      = true
      os_type     = "cloud-init"
      bootdisk    = "scsi0"
      hotplug     = "network,disk,usb"
      agent       = 1
      # Between 4 and 512, ignored if type is defined to serial
      vga_type   = "serial0"
      vga_memory = 128
      disks = [
        {
          type     = "scsi"
          storage  = "local-lvm"
          size     = "100G"
          iothread = 1
          ssd      = 1
          backup   = false
        },
        {
          type     = "scsi"
          storage  = "local-lvm"
          size     = "30G"
          iothread = 1
          ssd      = 1
          backup   = false
        }
      ]
      networks = [
        {
          model  = "virtio"
          bridge = "vmbr1"
          #tag      = -1
          firewall = true
        }
      ]
    }
  }
}
