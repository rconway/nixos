{ config, pkgs, lib, ... }:

let
  # Prerequisite setup...
  # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # sudo nix-channel --update nixos-unstable
  
  unstable = import <nixos-unstable> {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # desktop
    gnome-tweaks
    microsoft-edge
    google-chrome
    slack
    mission-center
    typora
    gnome-software
    go2tv

    # insync
    insync
    insync-nautilus

    # utils
    efibootmgr
    dnsutils
    p7zip
    openssl
    htop
    isd
    unstable.atuin
    unstable.tailscale
    gparted
    tldr
    smartmontools
    nvd
    duf

    # GitHub Copilot wants these...
    ripgrep
    bubblewrap
    socat

    # dev
    unstable.vscode
    meld
    postman
    docker-compose
    python3
    unstable.uv
    jq yq
    gh
    go
    gomplate
    lazydocker
    lazygit
    qgis

    # kubernetes
    kubectl
    kustomize
    kubernetes-helm
    unstable.k9s
    k3d
    kind
    pluto
    rke
  ];
}
