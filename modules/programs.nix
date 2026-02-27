{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    neovim
    homebank
    tutanota-desktop
    wget
    spotify
    killall
    kitty
    git
    cargo
    unzip
    wl-clipboard
    openrgb
    inputs.zen-browser.packages."${pkgs.system}".default
    brave
  ];

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  programs.fish.enable = true;
  programs.chromium.enable = true;

  # Writes current system packages to /etc/current-system-packages
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
}
