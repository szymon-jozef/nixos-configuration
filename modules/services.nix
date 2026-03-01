{ pkgs, ... }:

{
  services = {
    upower.enable = true;
    printing.enable = true;
    tailscale.enable = true;
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      systemService = false;
      user = "szymon";
    };
  };

  services.gnome.gnome-keyring.enable = false;
  services.dbus.packages = [ pkgs.kdePackages.kwallet ];
  security.pam.services.login.kwallet.enable = true;
  programs.gnupg.agent.enable = true;
  security.pam.services.sddm.kwallet.enable = true;
}
