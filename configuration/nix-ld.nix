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
  ];
}
