{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    { nixpkgs, catppuccin, ... }@inputs:
    {
      nixosConfigurations.pilecki = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostName = "pilecki";
          hostHardware = ./hardware/pilecki.nix;
        };
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };

      nixosConfigurations.pitagoras = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostName = "pitagoras";
          hostHardware = ./hardware/pitagoras.nix;
        };
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };
    };
}
