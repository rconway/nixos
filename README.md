# NixOS Configuration

This repository contains Nix-related artefacts:

* `configuration/`

  Contains reusable NixOS configuration files. It is structured to allow for easy customisation and management.

* `rconway/`

  Contains a nix flake for installation of nix packages on non-NixOS platforms

## Data Share Partition Requirement

The shared NixOS config mounts `/home/rconway/data` using `/dev/disk/by-partlabel/data`.

On each host using this repository, ensure exactly one partition has PARTLABEL `data`.
You can verify with:

```bash
lsblk -f -o +PARTLABEL
```

If required, set the partition label to `data` (replace disk and partition number):

```bash
sudo sgdisk --change-name=<partition-number>:data /dev/<disk>
sudo partprobe /dev/<disk>
lsblk -f -o +PARTLABEL
```
