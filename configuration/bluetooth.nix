{ config, pkgs, lib, ... }:

{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        ControllerMode = "dual";
      };
      Policy = {
        # Keep the adapter powered off after boot/login so known devices do not auto-connect.
        AutoEnable = false;
        # Disable BlueZ reconnect attempts for previously known devices.
        ReconnectAttempts = 0;
      };
    };
  };
}