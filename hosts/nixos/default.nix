{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}:
let
  hostCfg = import ./config.nix;
in
{

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    targets = {
      qt.enable = false;
      #  kde.enable = true;
    };

    base16Scheme = {
      scheme = "Stylix Blue Custom";
      author = "you";

      base00 = "#1f2430";
      base01 = "#242936";
      base02 = "#323844";
      base03 = "#4A5059";
      base04 = "#707a8c";
      base05 = "#cccac2";
      base06 = "#d9d7ce";
      base07 = "#f3f4f5";
      base08 = "#f28779";
      base09 = "#ffad66";
      base0A = "#ffd173";
      base0B = "#d5ff80";
      base0C = "#95e6cb";
      base0D = "#73d0ff";
      base0E = "#d4bfff";
      base0F = "#f27983";
    };

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  stylix.targets.gtk.enable = true;

  programs.thunar = {
    enable = true;

  };

  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
