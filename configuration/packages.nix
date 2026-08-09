{ config, pkgs, lib, ... }:

let
  # Keep most packages on the active nixos channel (unstable), but
  # pull qgis from stable while unstable's qscintilla/py3.14 build is broken.
  stable = import <nixos-stable> {
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
    onlyoffice-desktopeditors
    stable.vaults

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
    atuin
    tailscale
    gparted
    tldr
    smartmontools
    nvd
    duf
    dust

    # GitHub Copilot wants these...
    ripgrep
    bubblewrap
    socat

    # dev
    vscode
    meld
    postman
    docker-compose
    python3
    uv
    jq yq
    gh
    go
    gomplate
    lazydocker
    lazygit
    stable.qgis

    # kubernetes
    kubectl
    kustomize
    kubernetes-helm
    k9s
    k3d
    kind
    pluto
    rke
  ];

  programs.direnv.enable = true;
}
