{ config, pkgs, lib, ... }:

{
  # libvirt/KVM stack for local VMs (used by vagrant-libvirt for sysbox testing).
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    vagrant
    virt-viewer
  ];
}
