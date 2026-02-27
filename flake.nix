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
    { nixpkgs, catppuccin, ... }@inputs:
    let
      mkHost =
        hostName: hostHardware:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs hostName;
          };
          modules = [
            hostHardware
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
        pilecki = mkHost "pilecki" ./hardware/pilecki.nix;
        pitagoras = mkHost "pitagoras" ./hardware/pitagoras.nix;
      };
    };
}
