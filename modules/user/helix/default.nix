{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.helix.enable = lib.mkEnableOption "Enable helix editor";
  config = lib.mkIf config.user.helix.enable {
    # home.packages = with pkgs; [
    #   helix
    # ];

    programs.helix = {
      enable = true;
      settings = {
        theme = "stylix";
        # editor.cursor-shape = {
        #   normal = "block";
        #   insert = "bar";
        #   select = "underline";
        # };
      };
      # languages.language = [{
      #   name = "nix";
      #   auto-format = true;
      #   formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      # }];
      # themes = {
      #   base16_default = {
      #     "inherits" = "base16_default";
      #     "ui.background" = { };
      #   };
      # };
    };
  };
}
