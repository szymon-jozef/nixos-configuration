{ hostConfig, ... }:

{
  networking = {
    hostName = hostConfig.name;
    networkmanager.enable = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
