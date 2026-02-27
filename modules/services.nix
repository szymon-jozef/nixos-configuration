{ ... }:

{
  services = {
    upower.enable = true;
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    tailscale.enable = true;
  };

  security.pam.services.login.enableGnomeKeyring = true;
  programs.gnupg.agent.enable = true;

}
