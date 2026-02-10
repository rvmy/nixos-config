{
  config,
  lib,
  pkgs,
  ...
}:

{

  stylix = {
    enable = true;
    image = ../../assets/wallpapers/wallpaper1.jpg;
    polarity = "dark";

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
