{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.git.enable = lib.mkEnableOption "Enable Git";
  config = lib.mkIf config.user.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "rvmy";
          email = "260548273+rvmy@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
