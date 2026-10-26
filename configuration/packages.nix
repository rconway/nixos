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

  # Global overlay to patch the base VS Code package before it gets wrapped by vscode-fhs
  nixpkgs.overlays = [
    (final: prev: {
      vscode = prev.vscode.overrideAttrs (oldAttrs: {
        postFixup = (oldAttrs.postFixup or "") + ''
          echo "Applying executable permissions patch to bundled Copilot binaries..."
          find $out/lib/vscode/ -type f -name "copilot-runtime" -exec chmod +x {} \; 2>/dev/null || true
          find $out/lib/vscode/ -type f -name "*.node" -exec chmod +x {} \; 2>/dev/null || true
        '';
      });
    })
  ];

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
    omnissa-horizon-client
    mpv

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
    killall
    wl-clipboard
    gocryptfs
    chafa
    intel-gpu-tools

    # GitHub Copilot wants these...
    ripgrep
    bubblewrap
    socat

    # dev
    vscode-fhs
    zed-editor
    meld
    postman
    docker-compose
    python3
    uv
    jq 
    yq
    jwt-cli
    gh
    gcc
    go
    gomplate
    gettext
    s3cmd
    lazydocker
    lazygit
    stable.qgis
    distrobox
    drawio
    nodejs

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
