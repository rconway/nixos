
nix profile add ~/nixos/rconway#rconway

nix flake update --flake ~/nixos/rconway

nix profile upgrade rconway

nix profile remove rconway
