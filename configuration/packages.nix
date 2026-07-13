{ config, pkgs, lib, ... }:

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
    qgis

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
}
