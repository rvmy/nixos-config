{
  description = "A very basic single-user flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-master,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};

      # Helper functions
      auto = import ./lib/auto.nix { inherit lib; };

      # Paths
      hostsPath = ./hosts;
      systemModulesPath = ./modules/system;
      userModulesPath = ./modules/user;

      # Auto-discover
      hosts = auto.discoverHosts hostsPath;
      systemModules = auto.importAll systemModulesPath;
      userModules = auto.importAll userModulesPath;

      # NixOS System
      mkNixos =
        host:
        lib.nixosSystem {
          inherit system;
          modules = [
            stylix.nixosModules.stylix
            { networking.hostName = host; }
            (hostsPath + "/${host}")
          ]
          ++ systemModules;
        };

      # Home Manager
      mkHome =
        host:
        let
          hostPath = hostsPath + "/${host}";
          hostCfg = import (hostPath + "/config.nix");
          username = hostCfg.host.mainUser or (throw "host.username not defined in ${host}/config.nix");
          userFile = hostPath + "/home.nix";
        in
        {
          name = host;
          value = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = userModules ++ [
              stylix.homeModules.stylix
              {
                home.username = username;
                home.homeDirectory = "/home/${username}";
                home.stateVersion = "25.11";
              }
              userFile
            ];
            extraSpecialArgs = {
              pkgs-master = import nixpkgs-master { inherit system; };
            };
          };
        };
      allHomes = map mkHome hosts;
    in
    {
      nixosConfigurations = lib.genAttrs hosts mkNixos;
      homeConfigurations = lib.listToAttrs allHomes;
    };
}
