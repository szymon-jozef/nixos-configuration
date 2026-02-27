{ ... }:

{
  services = {
    upower.enable = true;
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    tailscale.enable = true;
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "szymon";
    };
  };

  security.pam.services.login.enableGnomeKeyring = true;
  programs.gnupg.agent.enable = true;

}
