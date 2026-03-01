{
  hostConfig,
  lib,
  config,
  ...
}:

{
  imports = [
    ./modules/audio.nix
    ./modules/bootloader.nix
    ./modules/locale.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/de.nix
  ];

  nix.settings = {
    substituters = [
      # Cache NixOS
      "https://cache.nixos.org"

      # Cache Kernel CachyOS
      "https://cache.garnix.io"
      "https://attic.xuyh0120.win/lantian"

      # Cache Hyprland
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [
      #  NixOS
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

      # Kernela
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc"

      # Hyprland
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11"; # Don't you fecking change me!!!

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    amdgpu.overdrive.enable = lib.mkIf (!hostConfig.isNvidia && hostConfig.overclock.enable) true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  hardware.nvidia = lib.mkIf hostConfig.isNvidia {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  networking.hostName = hostConfig.name;
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

}
