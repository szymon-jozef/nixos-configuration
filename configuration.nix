{
  hostName,
  ...
}:

{
  imports = [
    ./hardware/pilecki.nix
    ./modules/audio.nix
    ./modules/bootloader.nix
    ./modules/locale.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/de.nix
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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
  };

  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

}
