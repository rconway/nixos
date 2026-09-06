# Agent Init Context: nixos

## Repository Purpose
- This repo has two concerns:
- `configuration/`: modular NixOS system configuration.
- `rconway/`: standalone flake profile for non-NixOS installs via `nix profile`.

## Structure And Ownership
- Primary composition entrypoint: `configuration/configuration.nix`.
- Host-specific configs live in `hosts/<hostname>.nix` (e.g. `hosts/nixpad.nix`). These ARE in the repo and are the correct place to edit host-specific settings like bootloader, hostname, and stateVersion.
- `/etc/nixos/configuration.nix` is a symlink to the appropriate `hosts/<hostname>.nix` file.
- Cross-platform profile entrypoint: `rconway/flake.nix`.
- Profile usage docs: `rconway/README.md`.

## Active NixOS Module Map
- `kernel.nix`: kernel selection and kernel modules.
- `bluetooth.nix`: BlueZ enablement and adapter auto-enable policy.
- `network.nix`: NetworkManager enablement.
- `locale.nix`: timezone, locales, keyboard layout.
- `sudo.nix`: sudo rules.
- `gnome.nix`: X11 + GNOME + GDM.
- `printing.nix`: CUPS + static printer definition.
- `data-share.nix`: optional `/home/rconway/data` mount + Samba + prep service.
- `tailscale.nix`: resolved + resolv.conf fix unit + tailscale.
- `dns-overrides.nix`: static DNS overrides.
- `packages.nix`: host system packages.
- `gnome-extensions.nix`: GNOME extension packages.
- `home-manager.nix`: Home Manager module import (from `master`).
- `nix-ld.nix`: nix-ld for running unpatched dynamic binaries.
- `fonts.nix`: system font packages.
- `libvirt.nix`: libvirtd/KVM + virt-manager + vagrant (for local VMs, e.g. sysbox testing).

## Operational Assumptions
- Primary user/group: `rconway` with uid/gid 1000.
- Sudo policy grants passwordless ALL for `rconway`.
- Docker, libvirtd, and OpenSSH are enabled.
- PipeWire is enabled; PulseAudio disabled.
- Kernel package is `linuxPackages_latest` (set in `kernel.nix`).
- `rconway` is a member of the `libvirtd` group for passwordless VM management (e.g. vagrant-libvirt).

## Important Behavior Constraints
- `data-share.nix` intentionally keeps mount optional (`nofail`) for hosts without that disk.
- `tailscale.nix` uses systemd unit ordering for DNS resolver behavior.

## Package Management Split
- NixOS host packages live in `configuration/packages.nix`.
- Portable profile packages live in `rconway/flake.nix` as `packages.x86_64-linux.rconway`.
- Flake version metadata uses short git revision when available.

## Channel And Pinning Notes
- Root channels are expected to include `nixos` (unstable), `nixos-stable` (26.05), and `nixos-unstable` (unstable alias).
- `configuration/packages.nix` should treat `pkgs` as unstable by default via the `nixos` channel.
- `qgis` is intentionally pinned to `nixos-stable` due to unstable `qscintilla-qt6` build failures with Python 3.14.
- `configuration/home-manager.nix` currently imports Home Manager from `master`.

## Common Profile Commands (From Repo Docs)
- `nix flake update --flake <path>/nixos/rconway`
- `nix profile add ~/nixos/rconway#rconway`
- `nix profile add github:rconway/nixos?dir=rconway#rconway`
- `nix profile upgrade rconway`
- `nix profile remove rconway`

## Default Scope
- Unless explicitly told otherwise, assume all changes are scoped to `configuration/` (NixOS config only).
- Do not modify `rconway/flake.nix` or related profile files unless the user specifically requests it.

## Editing Guidance For Future Sessions
- Prefer small edits in module-specific files over broad edits in `configuration/configuration.nix`.
- Keep optional mount fallback semantics intact unless asked to change behavior.
- Be careful changing systemd ordering in tailscale/resolver logic.
- Keep host config (`hosts/<hostname>.nix`) and shared config (`configuration/configuration.nix`) concerns separated.