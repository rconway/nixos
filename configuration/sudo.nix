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

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.systemd1.manage-units" &&
          subject.user == "rconway") {
        return polkit.Result.YES;
      }
    });
  '';
}
