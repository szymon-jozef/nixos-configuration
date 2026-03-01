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
          SUBVOLUMES = "/home";
          ALLOW_USERS = [ hostConfig.username ];
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
        };
      };
    };
  };

  security.pam.services.sddm.kwallet.enable = true;
  security.pam.services.login.kwallet.enable = true;

  hardware.openrgb.enable = true;

  lact = hostConfig.overclock;
  xserver.videoDrivers = if hostConfig.isNvidia then [ "nvidia" ] else [ ];
}
