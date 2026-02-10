{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.zed.enable = lib.mkEnableOption "Enable Zed Editor";
  config = lib.mkIf config.user.zed.enable {
    programs.zed-editor = {
      enable = true;
    };
  };
}
