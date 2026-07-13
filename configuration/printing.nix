{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # But disable printer auto-discovery.
  systemd.services.cups-browsed.enable = false;
}
