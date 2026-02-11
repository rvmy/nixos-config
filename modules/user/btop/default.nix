{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.btop.enable = lib.mkEnableOption "Enable Waybar";
  config = lib.mkIf config.user.btop.enable {
    programs.btop.enable = true;

  };
}
