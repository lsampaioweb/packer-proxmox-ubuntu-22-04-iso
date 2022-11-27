# packer-proxmox-ubuntu-22-04-iso
Repository of a Packer module to create an Ubuntu 22.04 virtual machine (server or desktop) on Proxmox VE from an ISO file.

Run these commands on the Proxmox node (just once and on any node):
```bash
01 - Create the user that Packer will use.
  pveum user add packer@pve --firstname "Packer" --email "lsampaioweb@gmail.com" --comment "The user that Packer will use."

02 - Create a password for the user.
  uuid
  pveum passwd packer@pve

03 - Create a token for the user.
  pveum user token add packer@pve packer --comment "The token that Packer will use."

04 - Create a role for the user and set the permissions.
  pveum roleadd Packer -privs "Datastore.AllocateSpace, Datastore.Audit, Group.Allocate, Pool.Audit, Pool.Allocate, Sys.Audit, Sys.Modify, VM.Allocate, VM.Audit, VM.Clone, VM.Config.CDROM, VM.Config.CPU, VM.Config.Cloudinit, VM.Config.Disk, VM.Config.HWType, VM.Config.Memory, VM.Config.Network, VM.Config.Options, VM.Console, VM.Monitor, VM.PowerMgmt"

05 - Set the role to the user and API Token.
  pveum acl modify / -user packer@pve -role Packer
  pveum acl modify / -token 'packer@pve!packer' -role Packer
```

Run these commands on the computer that is running Packer:

```bash
01 - Save the password in the secret manager.
  secret-tool store --label="proxmox-packer-password" password proxmox-packer-password

02 - Save the API token in the secret manager.
  secret-tool store --label="proxmox-packer-token" token proxmox-packer-token

03 - Add the API token of the user to the ~/.bashrc file.
  nano ~/.bashrc
  # Function to unlock gnome keyring for headless logins.
  function unlock-keyring ()
  {
    read -rsp "Type your password: " pass
    export $(echo -n "$pass" | gnome-keyring-daemon --replace --unlock --daemonize)
    unset pass

    export PKR_VAR_PROXMOX_PACKER_TOKEN=$(secret-tool lookup token "proxmox-packer-token")
  }

04 - Run the unlock-keyring command on the terminal to unlock the secret - manager.
  source ~/.bashrc
  unlock-keyring  

05 - Create the necessary folders and files.
  git submodule add https://github.com/lsampaioweb/packer-proxmox-ubuntu-22-04-iso.git iso

  nano config.pkr.hcl
  packer {
    required_plugins {
      proxmox = {
        version = ">= 1.0.6"
        source  = "github.com/hashicorp/proxmox"
      }
    }
  }

  nano project.pkrvars.hcl
  vm_id             = 900
  vm_name           = "ubuntu-22-04-server-raw"
  iso_file          = "ubuntu-22-04-server-raw.iso"

06 - Run Packer to create the template.
  cd packer
  
  packer init config.pkr.hcl
  packer build -only="credencials.file.password" -var-file=project.pkrvars.hcl iso/.
  packer build -only="template.proxmox-iso.ubuntu" -var-file=project.pkrvars.hcl iso/.
  packer build -only="kvm-node.null.extra-config" -var-file=project.pkrvars.hcl iso/.
  or 
  ./pipeline.sh
```

# License:

[MIT](LICENSE "MIT License")

# Created by: 

1. Luciano Sampaio.
