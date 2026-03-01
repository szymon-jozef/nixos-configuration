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
      };

      mkHost =
        customConfig:
        let
          hostConfig = defaultHostConfig // customConfig;
        in
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
          bootType = "mbr";
          gaming = false;
          winboat = false;
        };

        pitagoras = mkHost {
          name = "pitagoras";
          hardware = ./hardware/pitagoras.nix;
          isNvidia = true;
          snapperHome = false;
        };

        paderewski = mkHost {
          name = "paderewski";
          hardware = ./hardware/paderewski.nix;
          autologin = false;
          cpu = "amd";
          overclock = {
            enable = true;
            settings = {
              version = 5;
              daemon = {
                log_level = "info";
                admin_group = "wheel";
                disable_clocks_cleanup = false;
              };
              apply_settings_timer = 5;
              gpus = {
                "1002:747E-1458:2413-0000:03:00.0" = {
                  fan_control_enabled = false;
                  fan_control_settings = {
                    mode = "curve";
                    static_speed = 1.0;
                    temperature_key = "edge";
                    interval_ms = 500;
                    curve = {
                      "40" = 0.2;
                      "50" = 0.3;
                      "60" = 0.4;
                      "70" = 0.5;
                      "80" = 0.7;
                    };
                    spindown_delay_ms = 0;
                    change_threshold = 0;
                  };
                  pmfw_options = {
                    acoustic_limit = 2202;
                    acoustic_target = 1820;
                    minimum_pwm = 20;
                    target_temperature = 80;
                    zero_rpm = true;
                    zero_rpm_threshold = 60;
                  };
                  power_cap = 260.0;
                  performance_level = "manual";
                  max_core_clock = 2920;
                  max_memory_clock = 1225;
                  voltage_offset = 0;
                  power_profile_mode_index = 1;
                };
              };
              current_profile = null;
              auto_switch_profiles = false;
            };
          };
        };
      };
    };
}
