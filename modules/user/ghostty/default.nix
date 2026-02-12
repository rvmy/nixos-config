{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.ghostty.enable = lib.mkEnableOption "Enable Ghostty";
  config = lib.mkIf config.user.ghostty.enable {
    programs.ghostty = {
      enable = true;
      # settings = {
      #   theme = "Ayu";
      #   font-family = "JetBrainsMono Nerd Font Mono";
      #   font-size = 10;
      #   window-padding-x = 5;
      #   window-padding-y = 5;
      #   window-decoration = true;
      #   cursor-style = "block";
      #   background = "black";
      #   background-opacity = 0.8;
      #   background-blur = 10;
      # };
    };

  };
}
