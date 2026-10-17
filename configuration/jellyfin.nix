{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;

    hardwareAcceleration = {
      enable = true;
      type = "qsv";
      device = "/dev/dri/renderD128";
    };

    transcoding = {
      enableHardwareEncoding = true;
    };

    # Make NixOS the source of truth for encoding settings.
    # Dashboard changes to these settings will be overwritten.
    forceEncodingConfig = true;
  };

  users.users.jellyfin.extraGroups = [
    "render"
    "video"
  ];
}
