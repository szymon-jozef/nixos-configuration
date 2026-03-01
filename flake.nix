{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      catppuccin,
      ...
    }@inputs:
    let
      mkHost =
        hostConfig:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs hostConfig;
          };
          modules = [
            hostConfig.hardware
            ./configuration.nix
            catppuccin.nixosModules.catppuccin
            (
              { ... }:
              {
                nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        pilecki = mkHost {
          name = "pilecki";
          hardware = ./hardware/pilecki.nix;
          isNvidia = false;
          bootType = "mbr";
          gaming = false;
          winboat = false;
        };

        pitagoras = mkHost {
          name = "pitagoras";
          hardware = ./hardware/pitagoras.nix;
          isNvidia = true;
          bootType = "gpt";
          gaming = true;
          winboat = true;
        };

        paderewski = mkHost {
          name = "paderewski";
          hardware = ./hardware/paderewski.nix;
          isNvidia = true;
          bootType = "gpt";
          gaming = true;
          winboat = true;
        };
      };
    };
}
