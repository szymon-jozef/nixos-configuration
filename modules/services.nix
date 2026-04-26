{
  pkgs,
  hostConfig,
  lib,
  ...
}:

{
  services = {
    # === printing ===
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # === syncthing ===
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      systemService = false;
      user = hostConfig.username;
    };

    # === keyring and stuff ===
    gnome.gnome-keyring.enable = false;
    dbus.packages = [ pkgs.kdePackages.kwallet ];

    # === backup ===
    snapper = lib.mkIf hostConfig.snapperHome {
      configs = {
        home = {
          SUBVOLUME = "/home";
          ALLOW_USERS = [ hostConfig.username ];
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
        };
      };
    };

    # === display manager ===
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
        settings = {
          Autologin = lib.mkIf hostConfig.autologin {
            Session = "hyprland-uwsm.desktop";
            User = hostConfig.username;
          };
        };
      };
    };

    # === hardware stuff ===
    hardware.openrgb.enable = true;
    lact = hostConfig.overclock;
    xserver.videoDrivers = if hostConfig.isNvidia then [ "nvidia" ] else [ ];
    xserver.enable = false;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    fwupd.enable = true;

    # === audio ===
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # === other stuff ===
    upower.enable = true;
    tailscale.enable = true;
    flatpak.enable = true;
  };
}
