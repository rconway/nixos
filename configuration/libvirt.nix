{ config, pkgs, lib, ... }:

{
  # libvirt/KVM stack for local VMs (used by vagrant-libvirt for sysbox testing).
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    vagrant
    virt-viewer

    # Build deps for `vagrant plugin install vagrant-libvirt` (native ruby-libvirt gem extension).
    pkg-config
    libvirt
    gnumake
    ruby
  ];

  #----------------------------------------------------------------------------------------------------
  # NOTE: Will need to manually run `vagrant plugin install vagrant-libvirt` after the system is built.
  #----------------------------------------------------------------------------------------------------
}
