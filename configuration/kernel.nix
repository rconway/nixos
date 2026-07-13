{ config, pkgs, lib, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernelModules = [
    # 🔧 Core networking and container support
    "ip_tables" "iptable_nat" "nf_nat" "nf_conntrack" "x_tables"
    "br_netfilter" "overlay" "veth" "tun"

    # 🖥️ Desktop, audio, and media
    "snd_hda_intel" "uvcvideo" "loop" "fuse" "kvm"

    # 🔐 Security and tracing
    "ecryptfs" "audit" "nf_defrag_ipv4" "nf_defrag_ipv6"

    # 💾 Storage and device management
    "dm_mod" "dm_crypt" "cryptd" "ext4" "btrfs" "xfs" "nfs" "cifs"

    # 🌐 VPNs and tunneling
    "wireguard" "ip6_tables" "ip_set" "nfnetlink"

    # 🧪 Misc compatibility
    "rtc_cmos" "rtc_core" "rtc_hctosys"
    "i2c_dev" "i2c_i801" "hid" "hid_generic" "usbhid" "usbcore" "usb_storage"
  ];
}
