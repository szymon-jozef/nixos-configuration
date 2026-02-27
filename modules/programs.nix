{
  pkgs,
  config,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
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

  ];

  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
    ubuntu
  ];

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
