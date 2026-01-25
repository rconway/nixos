
## update the flake with upstream (nixpkgs)

nix flake update --flake <path>/nixos/rconway

## add to profile

### local

* nix profile add ~/nixos/rconway#rconway

### github

* main
    * nix profile add github:rconway/nixos?dir=rconway#rconway
* Branch
    * nix profile add github:rconway/nixos?dir=rconway&ref=main#rconway
* Commit
    * nix profile add github:rconway/nixos?dir=rconway&rev=<commit>#rconway
* Tag
    * nix profile add github:rconway/nixos?dir=rconway&ref=v1.0.0#rconway
* ssh
    * nix profile add git+ssh://git@github.com/rconway/nixos?dir=rconway#rconway

### update the profile

nix profile upgrade rconway

## remove from profile

nix profile remove rconway
