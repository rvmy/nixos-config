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
