{
  config,
  lib,
  pkgs,
  ...
}:

{

  stylix = {
    enable = true;
    polarity = "dark";
  };

  stylix.opacity = {
    terminal = 1.0;
    desktop = 1.0;
    applications = 1.0;
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
