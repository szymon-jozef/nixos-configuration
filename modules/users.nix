{ pkgs, hostConfig, ... }:

{
  users.users.${hostConfig.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  users.groups = {
    docker = { };
  };
}
