# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./kernel.nix
      ./network.nix
      ./locale.nix
      ./sudo.nix
      ./gnome.nix
      ./printing.nix
      ./data-share.nix
      ./tailscale.nix
      ./packages.nix
      ./gnome-extensions.nix
    ];

  # Firmware safety net - if needed
  # Should hopefully already be covered by hardware scan.
  #hardware.enableAllFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.fwupd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rconway = {
    isNormalUser = true;
    uid = 1000;
    group = "rconway";
    description = "Richard Conway";
    extraGroups = [ "networkmanager" "wheel" "docker" "users" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.groups.rconway.gid = 1000;
  users.groups.users.gid = 100;

  # zsh
  programs.zsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
  programs.git.enable = true;

  programs.gnome-terminal.enable = true;

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
