{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  home-manager.backupFileExtension = "hm-backup";

  home-manager.users.rconway = { pkgs, config, ... }: {
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

    home.file.".ssh/config".source =
      config.lib.file.mkOutOfStoreSymlink "/home/rconway/scripts/dotfiles/ssh_config";

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "26.05";
  };
}
