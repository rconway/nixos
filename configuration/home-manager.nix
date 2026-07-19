{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
  username = "rconway";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  home-manager.backupFileExtension = "hm-backup";

  home-manager.users.${username} = { pkgs, config, ... }:
  let
    gnomeTerminalDefaultProfileId = "b1dcc9dd-5262-4d8d-a863-c897e6d979b9";
  in
  {
    # home.packages = [ pkgs.atool pkgs.httpie ];
    programs.zsh = {
      enable = true;
      initContent = ''
        if [ -f /home/rconway/scripts/dotfiles/zshrc ]; then
          source /home/rconway/scripts/dotfiles/zshrc
        fi
      '';
    };

    programs.git = {
      enable = true;
      settings = {
        user.name = "Richard Conway";
        user.email = "richard@rconway.co.uk";
        diff.tool = "meld";
        pull.rebase = false;
        init.defaultBranch = "main";
      };
    };

    programs.vim = {
      enable = true;
      extraConfig = ''
        set mouse-=a
      '';
    };

    programs.gnome-terminal = {
      enable = true;
      profile = {
        "${gnomeTerminalDefaultProfileId}" = {
          default = true;
          visibleName = config.home.username;
          loginShell = true;
        };
      };
    };

    # Home Manager's gnome-terminal module does not expose default-size options.
    # Keep dconf usage scoped only to window size.
    dconf.settings = {
      "org/gnome/terminal/legacy/profiles:/:${gnomeTerminalDefaultProfileId}" = {
        default-size-columns = 132;
        default-size-rows = 40;
      };
    };

    home.file.".ssh/config".source =
      config.lib.file.mkOutOfStoreSymlink "/home/rconway/scripts/dotfiles/ssh_config";

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "26.05";
  };
}
