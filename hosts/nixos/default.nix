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
    polarity = "dark";

    opacity = {
      terminal = 1.0;
      desktop = 1.0;
      applications = 1.0;
    };

    image = hostCfg.host.stylixImage;
  };

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
