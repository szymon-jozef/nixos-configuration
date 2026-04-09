{
  pkgs,
  config,
  inputs,
  hostConfig,
  lib,
  ...
}:

{
  nixpkgs.config.permittedInsecurePackages = [ "electron-38.8.4" ];
  environment.systemPackages =
    with pkgs;
    [
      # Browsers
      brave
      tutanota-desktop
      inputs.zen-browser.packages."${pkgs.system}".default

      # Texting
      vesktop
      signal-desktop

      # Music
      spotify

      # Cli
      kitty
      neovim
      wget
      git
      ripgrep
      killall
      unzip
      wl-clipboard
      ffmpeg

      # Gui stuff
      homebank
      openrgb
      gimp
      rstudio

      # System stuff
      waypaper
      awww
      kdePackages.kwallet
      kdePackages.kwallet-pam
      kdePackages.kwalletmanager
      hyprpolkitagent
      modprobed-db

      # virtualisation
      distrobox
      quickemu
    ]
    ++ lib.optionals hostConfig.winboat [
      # winboat
    ]
    ++ lib.optionals hostConfig.gaming [
      mangohud
      prismlauncher
      heroic
      lutris
      rpcs3
      pcsx2
      alvr
    ];

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
    gamemode.enable = lib.mkIf hostConfig.gaming true;
    steam = lib.mkIf hostConfig.gaming {
      enable = true;
      gamescopeSession.enable = true;
    };

    gnupg.agent.enable = true;
    obs-studio.enable = true;

    direnv.enable = true;

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  catppuccin.enable = true;

  # Writes current system packages to /etc/current-system-packages
  environment.etc."current-system-packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
}
