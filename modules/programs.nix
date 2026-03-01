{
  pkgs,
  config,
  inputs,
  hostConfig,
  lib,
  ...
}:

{
  environment.systemPackages =
    with pkgs;
    [
      # Browsers
      brave
      tutanota-desktop
      inputs.zen-browser.packages."${pkgs.system}".default

      # Texting
      vesktop
      signal-desktop-bin

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

      # Gui stuff
      homebank
      openrgb

      # System stuff
      waypaper
      swww
      kdePackages.kwallet
      kdePackages.kwallet-pam
      kdePackages.kwalletmanager

      # virtualisation
      distrobox
    ]
    ++ lib.optionals hostConfig.winboat [
      winboat
    ]
    ++ lib.optionals hostConfig.gaming [
      prismlauncher
    ];

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
    ubuntu
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
