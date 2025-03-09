terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_tls_insecure     = true
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}

resource "proxmox_vm_qemu" "test_server" {
  count            = 0
  name             = "test-vm-${count.index + 1}"
  target_node      = var.pm_host
  agent            = 1
  cores            = 2
  memory           = 2048
  boot             = "order=scsi0"
  clone            = var.pm_vm_template
  scsihw           = "virtio-scsi-single"
  automatic_reboot = true
  nameserver       = "1.1.1.1 8.8.8.8"
  ipconfig0        = "ip=192.168.178.100/24,gw=192.168.178.1,ip6=dhcp"
  skip_ipv6        = true
  ciupgrade        = true
  ciuser           = "root"
  cipassword       = "password"

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = "20G"
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }


  sshkeys = <<EOF
  ${var.ssh_key}
  EOF

}
