{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.helix.enable = lib.mkEnableOption "Enable helix editor";
  config = lib.mkIf config.user.helix.enable {
    home.packages = with pkgs; [
      helix
    ];
  };
}
