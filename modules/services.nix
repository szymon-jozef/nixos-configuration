{
  pkgs,
  hostConfig,
  lib,
  ...
}:

{
  services = {
    upower.enable = true;
    printing.enable = true;
    tailscale.enable = true;
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      systemService = false;
      user = hostConfig.username;
    };

    gnome.gnome-keyring.enable = false;
    dbus.packages = [ pkgs.kdePackages.kwallet ];

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

    hardware.openrgb.enable = true;
    lact = hostConfig.overclock;

    xserver.videoDrivers = if hostConfig.isNvidia then [ "nvidia" ] else [ ];

    xserver.enable = false;

    # Audio

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
