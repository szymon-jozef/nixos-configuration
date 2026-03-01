{ pkgs, ... }:

{
  users.users.szymon = {
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
