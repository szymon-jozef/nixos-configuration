{
  pkgs,
  hostConfig,
  inputs,
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
      # lutris
      rpcs3
      pcsx2
    ];
}
