{ ... }:

{
  programs = {
    # alvr =  {
    #   enable = true;
    #   openFirewall = true;
    # };

    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };
  };
}
