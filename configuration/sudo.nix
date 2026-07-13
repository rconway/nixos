{ config, pkgs, lib, ... }:

{
  security.sudo.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "rconway" ];
      host = "ALL";
      runAs = "ALL";
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
