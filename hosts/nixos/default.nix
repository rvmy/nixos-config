{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostCfg = import ./config.nix;
in
{

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";

    opacity = {
      terminal = 1.0;
      desktop = 1.0;
      applications = 1.0;
    };

    base16Scheme = {
      scheme = "Stylix Blue Custom";
      author = "you";

      base00 = "#081522"; # Deep Navy (background)
      base01 = "#0B1C2D"; # Dark Blue
      base02 = "#102A43"; # Midnight Blue
      base03 = "#1C3A5F"; # Slate Blue
      base04 = "#6B7C93"; # Muted Gray
      base05 = "#E6EDF3"; # Off White (text)
      base06 = "#B0BEC5"; # Light Gray
      base07 = "#FFFFFF";

      base08 = "#EB5757"; # Red
      base09 = "#F2994A"; # Orange
      base0A = "#F2C94C"; # Amber
      base0B = "#2BB0A6"; # Teal
      base0C = "#2D9CDB"; # Cyan
      base0D = "#2F80ED"; # Stylix Blue
      base0E = "#BB6BD9"; # Magenta
      base0F = "#56A0FF"; # Soft Blue
    };
    image = hostCfg.host.stylixImage;

  };

  stylix.targets.gtk.enable = true;
  users.users.rami = {
    isNormalUser = true;
    description = "rami";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      # "disk"
    ];
  };

  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
