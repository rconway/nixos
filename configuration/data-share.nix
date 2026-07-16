{ config, pkgs, lib, ... }:

{
  # Data-share mount configuration.
  #
  # This mount is optional so the same configuration works on hosts that
  # do not have the data partition. On those hosts, /home/rconway/data is
  # used as a local fallback directory.
  fileSystems."/home/rconway/data" = {
    device = "/dev/disk/by-partlabel/data";
    fsType = "btrfs";
    options = [
      "subvol=/@data/@rconway"
      "compress=zstd:1"
      "defaults"
      # Ensure mountpoint exists before mount is attempted.
      "x-mount.mkdir"
      # Do not fail boot when this device is missing on other hosts.
      "nofail"
      # Keep missing-device boot delay short.
      "x-systemd.device-timeout=1s"
    ];
  };

  # Samba service and Work share definition.
  # Create the Samba password once with:
  #   sudo smbpasswd -a rconway
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "rconway@${config.networking.hostName} (Work)";
        "security" = "user";
        "map to guest" = "Bad User";
        "dns proxy" = "no";
      };

      "Work" = {
        "path" = "/home/rconway/data/Work";
        "comment" = "Work share for rconway";
        "browseable" = "yes";
        "writable" = "yes";
        "guest ok" = "no";
        "valid users" = "rconway";
        "force user" = "rconway";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  # Prepare data-share directories on all hosts:
  # - with partition mounted: directories are created in the mounted filesystem
  # - without partition: directories are created in local fallback path
  systemd.services.prepare-data-share-paths = {
    description = "Prepare data-share directories for Samba";
    wantedBy = [ "multi-user.target" ];
    # Ensure paths exist before SMB daemon starts.
    before = [ "samba-smbd.service" ];
    after = [ "local-fs.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      install -d -m 0755 -o rconway -g rconway /home/rconway/data
      install -d -m 0755 -o rconway -g rconway /home/rconway/data/Work
    '';
  };
}
