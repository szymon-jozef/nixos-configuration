{ ... }:

{
  imports = [
    ./modules/audio.nix
    ./modules/bootloader.nix
    ./modules/locale.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/de.nix
    ./modules/settings.nix
    ./modules/hardware.nix
    ./modules/networking.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.11"; # Don't you fecking change me!!!
}
