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
- `network.nix`: NetworkManager enablement.
- `locale.nix`: timezone, locales, keyboard layout.
- `sudo.nix`: sudo rules.
- `gnome.nix`: X11 + GNOME + GDM.
- `printing.nix`: CUPS + static printer definition.
- `data-share.nix`: optional `/home/rconway/data` mount + Samba + prep service.
- `tailscale.nix`: resolved + resolv.conf fix unit + tailscale.
- `packages.nix`: host system packages.
- `gnome-extensions.nix`: GNOME extension packages.

## Operational Assumptions
- Primary user/group: `rconway` with uid/gid 1000.
- Sudo policy grants passwordless ALL for `rconway`.
- Docker and OpenSSH are enabled.
- PipeWire is enabled; PulseAudio disabled.
- Kernel package is `linuxPackages_zen`.

## Important Behavior Constraints
- `data-share.nix` intentionally keeps mount optional (`nofail`) for hosts without that disk.
- `tailscale.nix` uses systemd unit ordering for DNS resolver behavior.

## Package Management Split
- NixOS host packages live in `configuration/packages.nix`.
- Portable profile packages live in `rconway/flake.nix` as `packages.x86_64-linux.rconway`.
- Flake version metadata uses short git revision when available.

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