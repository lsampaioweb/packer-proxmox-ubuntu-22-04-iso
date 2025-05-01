# packer-proxmox-ubuntu-iso
Repository of a Packer module to create an Ubuntu 22.04 virtual machine (server or desktop) on Proxmox VE from an ISO file.

Run these commands on the Proxmox node (just once and on any node):
```bash
01 - Create the user that Packer will use.
  pveum user add packer@pve --firstname "Packer" --email "lsampaioweb@gmail.com" --comment "The user that Packer will use."

02 - Create a password for the user. Copy the value, we will use it later.
  uuid
  pveum passwd packer@pve

03 - Create a token for the user. Copy the value, we will use it later.
  pveum user token add packer@pve packer --comment "The token that Packer will use."

04 - Create a role for the user and set the permissions.
  pveum roleadd Packer -privs "Datastore.Audit, Datastore.AllocateSpace, Group.Allocate, Pool.Audit, Pool.Allocate, SDN.Use, Sys.Audit, Sys.Modify, VM.Allocate, VM.Audit, VM.Clone, VM.Config.CDROM, VM.Config.CPU, VM.Config.Cloudinit, VM.Config.Disk, VM.Config.HWType, VM.Config.Memory, VM.Config.Network, VM.Config.Options, VM.Console, VM.Monitor, VM.PowerMgmt"

05 - Set the role to the user and API Token.
  pveum acl modify / -user packer@pve -role Packer
  pveum acl modify / -token 'packer@pve!packer' -role Packer
```

Run these commands on the computer that is running Packer:

```bash
01 - Save the password in the secret manager.
  secret-tool store --label="proxmox-packer-password" password "proxmox-packer-password"

02 - Confirm the password was correctly saved in the secret manager.
  secret-tool lookup password "proxmox-packer-password"

03 - Save the API token in the secret manager.
  secret-tool store --label="proxmox-packer-token" token "proxmox-packer-token"

04 - Confirm the token was correctly saved in the secret manager.
  secret-tool lookup token "proxmox-packer-token"

05 - Add the API token of the user to the ~/.bashrc file.
  nano ~/.bashrc
  export PKR_VAR_PROXMOX_PACKER_TOKEN=$(secret-tool lookup token "proxmox-packer-token")

06 - Run the source command on the terminal.
  source ~/.bashrc
```

This repository is to be used as a sub-module on other repositories.

See other repositories that use it: <br/>
1. [proxmox-ubuntu-server-raw](https://github.com/lsampaioweb/proxmox-ubuntu-server-raw "proxmox-ubuntu-server-raw").

#
### License:

[MIT](LICENSE "MIT License")

#
### Created by:

1. Luciano Sampaio.
