{
  config,
  pkgs,
  lib,
  ...
}:
let
  # wallpaperDir = "${config.home.homeDirectory}/Pictures/Wallpapers";
in
{
  options.user.rofi.enable = lib.mkEnableOption "Enable Rofi";

  config = lib.mkIf config.user.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;

      extraConfig = {
        modi = "drun,run,window";
        show-icons = true;
        drun-display-format = "{name}";
        display-drun = "Applications:";
        display-window = "Windows:";
      };

      theme = lib.mkForce (
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "${config.stylix.base16Scheme.base00}";
            bg-alt = mkLiteral "${config.stylix.base16Scheme.base01}";
            selected = mkLiteral "${config.stylix.base16Scheme.base03}";
            foreground = mkLiteral "${config.stylix.base16Scheme.base05}";
            border-color = mkLiteral "${config.stylix.base16Scheme.base02}";
            active = mkLiteral "${config.stylix.base16Scheme.base0B}";
            text-selected = mkLiteral "${config.stylix.base16Scheme.base07}";
            text-color = mkLiteral "${config.stylix.base16Scheme.base05}";
            urgent = mkLiteral "${config.stylix.base16Scheme.base0E}";

            background-color = mkLiteral "transparent";
            margin = mkLiteral "0";
            padding = mkLiteral "0";
            spacing = mkLiteral "0";
          };

          "window" = {
            location = mkLiteral "center";
            width = mkLiteral "600";
            background-color = mkLiteral "${config.stylix.base16Scheme.base00}E6";
            border = mkLiteral "2px";
            border-color = mkLiteral "${config.stylix.base16Scheme.base02}";
            border-radius = mkLiteral "10px";
          };

          "mainbox" = {
            padding = mkLiteral "12px";
          };

          "prompt" = {
            text-color = mkLiteral "@text-selected";
          };

          "entry" = {
            placeholder = "Search";
            placeholder-color = mkLiteral "@selected";
          };

          "inputbar" = {
            background-color = mkLiteral "@bg-alt";
            border-radius = mkLiteral "8px";
            padding = mkLiteral "8px 16px";
            spacing = mkLiteral "8px";
            children = mkLiteral "[ prompt, entry ]";
          };

          "listview" = {
            lines = mkLiteral "10";
            columns = mkLiteral "1";
            fixed-height = mkLiteral "false";
            border = mkLiteral "0";
            padding = mkLiteral "12px 0 0";
            spacing = mkLiteral "4px";
            scrollbar = mkLiteral "true";
          };

          "scrollbar" = {
            handle-width = mkLiteral "4px";
            handle-color = mkLiteral "@text-selected";
            background-color = mkLiteral "@bg-alt";
            border-radius = mkLiteral "4px";
          };

          "element" = {
            padding = mkLiteral "8px";
            spacing = mkLiteral "8px";
            border-radius = mkLiteral "6px";
          };

          "element normal.normal" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
          };

          "element normal.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@bg";
          };

          "element normal.active" = {
            background-color = mkLiteral "@active";
            text-color = mkLiteral "@bg";
          };

          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
          };

          "element selected.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@bg";
          };

          "element selected.active" = {
            background-color = mkLiteral "@foreground";
            text-color = mkLiteral "@bg";
          };

          "element-icon" = {
            size = mkLiteral "1em";
            vertical-align = mkLiteral "0.5";
          };

          "element-text" = {
            text-color = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
          };

        }
      );
    };
  };

}
