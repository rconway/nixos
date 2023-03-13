{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rconway = {
    isNormalUser = true;
    description = "Richard Conway";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
    # obsidian
    #  firefox
    #  thunderbird
    ];
  };

  security.sudo.extraRules= [
    {  users = [ "rconway" ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  # imports = [ /home/rconway/user.nix ];
}
