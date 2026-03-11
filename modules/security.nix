{ hostConfig, lib, ... }:

{
  security = {
    pam = {
      services.sddm.kwallet.enable = true;
      services.login.kwallet.enable = true;
      loginLimits = lib.mkIf (hostConfig.name == "paderewski") [
        {
          domain = "@wheel";
          item = "memlock";
          type = "soft";
          value = "16777216";
        }
        {
          domain = "@wheel";
          item = "memlock";
          type = "hard";
          value = "16777216";
        }
      ];
    };
    polkit.enable = true;
    rtkit.enable = true;
  };
}
