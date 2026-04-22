{ ... }:

{
  imports = [
    ./modules/bootloader.nix
    ./modules/locale.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/settings.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/security.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  zramSwap.enable = true;

  system.stateVersion = "25.11"; # Don't you fecking change me!!!

}
