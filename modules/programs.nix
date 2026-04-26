{
  pkgs,
  config,
  inputs,
  hostConfig,
  lib,
  ...
}:

{

  imports = [
    ./programs/packages.nix
  ]
  ++ lib.optional hostConfig.gaming ./programs/gaming.nix;

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    noto
    jetbrains-mono
    ubuntu
    symbols-only
  ];

  programs = {
    fish.enable = true;
    chromium.enable = true;
    java.enable = true;

    gnupg.agent.enable = true;
    obs-studio.enable = true;

    direnv.enable = true;

    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage =
      #  inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  catppuccin = {
    enable = true;
    accent = "sapphire";
  };

  # Writes current system packages to /etc/current-system-packages
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
}
