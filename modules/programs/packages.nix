{
  pkgs,
  hostConfig,
  inputs,
  pkgs-stable,
  lib,
  ...
}:

let
  rstudio-with-packages = pkgs-stable.rstudioWrapper.override {
    # we use stable, because unstable is broken rn
    packages = with pkgs-stable.rPackages; [
      # additional packages for rstudio here
      ggplot2
    ];
  };
in
{
  environment.systemPackages =
    with pkgs;
    [
      # Browsers
      brave
      tutanota-desktop
      inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default

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
      rstudio-with-packages

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
