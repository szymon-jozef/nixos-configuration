{ hostConfig, lib, ... }:

{
  security = {
    pam = {
      services.sddm.kwallet.enable = true;
      services.login.kwallet.enable = true;
    };
    polkit.enable = true;
    rtkit.enable = true;
  };
}
