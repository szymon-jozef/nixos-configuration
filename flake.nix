{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    #hyprland.url = "github:hyprwm/Hyprland";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      catppuccin,
      agenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-38.8.4"
          ];
        };

      };

      defaultHostConfig = {
        username = "szymon";
        isNvidia = false;
        cpu = "intel";
        bootType = "gpt";
        gaming = true;
        winboat = true;
        snapperHome = true;
        autologin = true;
        overclock = {
          enable = false;
        };
        maxJobs = "auto";
        cores = 0;
      };

      mkHost =
        customConfig:
        let
          hostConfig = defaultHostConfig // customConfig;
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs hostConfig pkgs-stable;
          };
          modules = [
            hostConfig.hardware
            ./configuration.nix
            catppuccin.nixosModules.catppuccin
            agenix.nixosModules.default
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
          bootType = "mbr";
          gaming = false;
          winboat = false;
        };

        pitagoras = mkHost {
          name = "pitagoras";
          hardware = ./hardware/pitagoras.nix;
          isNvidia = true;
          snapperHome = false;
          maxJobs = 1;
          cores = 1;
        };

        paderewski = mkHost {
          name = "paderewski";
          hardware = ./hardware/paderewski.nix;
          autologin = true;
          snapperHome = true;
          cpu = "amd";
        };
      };
    };
}
