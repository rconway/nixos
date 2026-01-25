{
  description = "RConway reproducible profile";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Human-readable version metadata
      version =
        if self ? rev
        then builtins.substring 0 7 self.rev
        else "dev";
    in {
      packages.${system}.rconway = pkgs.buildEnv {
        name = "rconway-${version}";

        # Optional but nice: include version metadata
        meta = {
          inherit version;
          description = "RConway profile";
        };

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
          pkgs.gotop
          pkgs.gtop
          pkgs.kubectl
        ];
      };
    };
}
