{ ... }:

{
  security = {
    pam.services.sddm.kwallet.enable = true;
    pam.services.login.kwallet.enable = true;
    polkit.enable = true;
    rtkit.enable = true;
  };
}
