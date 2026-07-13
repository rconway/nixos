{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.clipboard-history
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.steal-my-focus-window
  ];
}
