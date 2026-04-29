{
  pkgs,
  hostConfig,
  lib,
  inputs,
  ...
}:

{
  environment.systemPackages =
    with pkgs;
    [
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
      inputs.agenix.packages."${system}".default

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
      winboat
    ];
}
