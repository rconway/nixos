# nix-ld: lets dynamically-linked non-Nix binaries (e.g. pip-installed manylinux
# wheels in a venv) find shared libraries via a standard dynamic linker path.
#
# Baseline list below is from https://wiki.nixos.org/wiki/Nix-ld.
# To find a library missing from this list: run the failing program, note the
# missing .so name in the error, then look up which package provides it with:
#   nix run github:nix-community/nix-index-database -- lib/<missing>.so --top-level
{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Common runtime dependencies for unpatched command-line tools and native
    # language extensions.
    stdenv.cc.cc # libstdc++.so.6 - needed by numpy, pyzmq, etc.
    zlib
    zstd
    curl
    openssl
    attr
    libssh
    bzip2
    libxml2
    acl
    libsodium
    util-linux
    xz
    systemd
    expat
    libffi
    libxcrypt-legacy
    sqlite
    ncurses
    readline
    # Docker/Kubernetes CLIs generally need no extra shared libraries; daemon
    # configuration is handled separately from nix-ld.

    # GUI and graphics libraries used by editor tools and prebuilt developer
    # applications.
    glib
    gtk2
    gtk3
    nspr
    nss
    libGL
    libdrm
    libgbm
    libxkbcommon
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxtst
    libxcb
  ];
}
