{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [
    mangohud
    # heroic
    protonup-qt
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };
}
