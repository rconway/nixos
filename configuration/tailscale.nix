{ config, pkgs, lib, ... }:

{
  # DNS configuration that works with Tailscale
  services.resolved.enable = true;
  networking.resolvconf.enable = false; # Avoid conflict
  systemd.services.fix-resolvconf = {
    description = "Patch /etc/resolv.conf to point to systemd-resolved stub";
    wantedBy = [ "multi-user.target" ];           # Ensures it's part of boot
    before = [ "tailscaled.service" ];            # Runs before tailscaled
    after = [ "systemd-resolved.service" ];       # Waits for stub to exist
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf";
    };
  };

  services.tailscale.enable = true;
}
