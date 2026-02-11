{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.waybar.enable = lib.mkEnableOption "Enable Waybar";
  config = lib.mkIf config.user.waybar.enable {
    programs.waybar.enable = true;
  };
}
