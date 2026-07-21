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

      "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid
          pkgs.gnomeExtensions.bing-wallpaper-changer.extensionUuid
          pkgs.gnomeExtensions.coverflow-alt-tab.extensionUuid
          pkgs.gnomeExtensions.clipboard-history.extensionUuid
          pkgs.gnomeExtensions.quick-settings-audio-panel.extensionUuid
          pkgs.gnomeExtensions.steal-my-focus-window.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/clipboard-history" = {
        display-mode = 0;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = false;
        background-opacity = 0.8;
        click-action = "focus-minimize-or-appspread";
        custom-theme-shrink = true;
        dash-max-icon-size = 32;
        disable-overview-on-startup = true;
        dock-fixed = true;
        dock-position = "LEFT";
        extend-height = true;
        height-fraction = 0.9;
        multi-monitor = true;
        preferred-monitor = -2;
        preferred-monitor-by-connector = "eDP-1";
        scroll-action = "switch-workspace";
        show-mounts = false;
        show-trash = false;
        transparency-mode = "FIXED";
      };

      # Keep Bing wallpaper declarative for stable preferences only.
      # Excludes dynamic keys (bing-json, selected-image, state) that change daily.
      "org/gnome/shell/extensions/bingwallpaper" = {
        delete-previous = true;
        download-folder = "~/Pictures/BingWallpaper/";
        icon-name = "bing-symbolic";
      };

      "org/gnome/shell/extensions/quick-settings-audio-panel" = {
        always-show-input-volume-slider = true;
        version = 2;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Primary><Alt>t";
        command = "gnome-terminal";
        name = "Launch Terminal";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>e";
        command = "nautilus";
        name = "Launch File Explorer";
      };
    };

    home.file.".ssh/config".source =
      config.lib.file.mkOutOfStoreSymlink "/home/rconway/scripts/dotfiles/ssh_config";

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "26.05";
  };
}
