# NixOS Configuration

This repository contains Nix-related artefacts:

* `configuration/`

  Contains reusable NixOS configuration files. It is structured to allow for easy customisation and management.

* `hosts/`

  Contains host-specific NixOS configuration files (e.g. `hosts/nixpad.nix`). On each host, `/etc/nixos/configuration.nix` is a symlink to the appropriate file here.

* `rconway/`

  Contains a nix flake for installation of nix packages on non-NixOS platforms

## Channel Strategy

System builds currently assume these root channels exist:

* `nixos` -> `https://channels.nixos.org/nixos-unstable`
* `nixos-stable` -> `https://channels.nixos.org/nixos-26.05`
* `nixos-unstable` -> `https://channels.nixos.org/nixos-unstable`

Create/reset them with:

```bash
sudo nix-channel --remove nixos || true
sudo nix-channel --remove nixos-stable || true
sudo nix-channel --remove nixos-unstable || true

sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos
sudo nix-channel --add https://channels.nixos.org/nixos-26.05 nixos-stable
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable

sudo nix-channel --update
sudo nix-channel --list
```

The `configuration/packages.nix` module installs most packages from `nixos` (unstable).
`qgis` is intentionally sourced from `nixos-stable` until the unstable `qscintilla-qt6`
build issue is resolved.

Home Manager is imported in `configuration/home-manager.nix` from the Home Manager
`master` tarball to match the unstable system channel direction.

Useful commands:

```bash
sudo nix-channel --list
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade
```

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
