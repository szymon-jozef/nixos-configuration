{ hostConfig, ... }:

{
  networking = {
    hostName = hostConfig.name;
    networkmanager.enable = true;
  };
}
