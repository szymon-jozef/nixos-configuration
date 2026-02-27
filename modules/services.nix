{ ... }:

{
  services.upower.enable = true;
  services.printing.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.gnupg.agent.enable = true;

}
