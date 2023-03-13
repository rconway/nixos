{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    meld
    google-chrome
    git
    vscode
    minikube
    kubectl
    kubernetes-helm
    displaylink
    gnome.gnome-tweaks
    gnomeExtensions.babar
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.dash-to-dock
    p7zip
    guake
    go
    firefox
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];
}
