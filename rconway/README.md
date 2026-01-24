
nix profile add ~/nixos/rconway#rconway

nix profile add github:rconway/nixos?dir=rconway#rconway
# Branch
nix profile add github:rconway/nixos?dir=rconway&ref=main#rconway
# Commit
nix profile add github:rconway/nixos?dir=rconway&rev=<commit>#rconway
# Tag
nix profile add github:rconway/nixos?dir=rconway&ref=v1.0.0#rconway
# ssh
nix profile add git+ssh://git@github.com/rconway/nixos?dir=rconway#rconway

nix flake update --flake ~/nixos/rconway

nix profile upgrade rconway

nix profile remove rconway
