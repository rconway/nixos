{
  description = "RConway reproducible profile";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.rconway = pkgs.buildEnv {
        name = "rconway";
        paths = [
          pkgs.btop
          pkgs.docker-compose
          pkgs.isd
          pkgs.p7zip
          pkgs.zsh
          pkgs.lazydocker
          pkgs.duf
          pkgs.k3d
          pkgs.k9s
        ];
      };
    };
}
