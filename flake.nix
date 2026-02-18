{
  description = "A very basic single-user flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    astal.url = "github:aylur/astal";
    ags.url = "github:aylur/ags";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-master,
      home-manager,
      stylix,

      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};

      # Helper functions
      auto = import ./lib/auto.nix { inherit lib; };
      scriptsLib = import ./lib/scripts.nix { inherit lib pkgs; };

      # Paths
      hostsPath = ./hosts;
      systemModulesPath = ./modules/system;
      userModulesPath = ./modules/user;
      globalScriptsPath = ./scripts;

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
            { networking.hostName = host; }
            (hostsPath + "/${host}")
            stylix.nixosModules.stylix
          ]
          ++ systemModules;
          specialArgs = {
            # pkgs-master = import nixpkgs-master { inherit system; };
            pkgs-stable = import nixpkgs-stable { inherit system; };
          };
        };

      # Home Manager
      mkHome =
        host:
        let
          hostPath = hostsPath + "/${host}";
          hostCfg = import (hostPath + "/config.nix");
          username = hostCfg.host.mainUser or (throw "host.username not defined in ${host}/config.nix");
          userFile = hostPath + "/home.nix";

          globalScripts = scriptsLib.mkScriptsFromDir globalScriptsPath;
          hostScriptsPath = hostPath + "/scripts";
          hostScripts = scriptsLib.mkScriptsFromDir hostScriptsPath;
          allScripts = globalScripts ++ hostScripts;
        in
        {
          name = host;
          value = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = userModules ++ [

              {
                home.username = username;
                home.homeDirectory = "/home/${username}";
                home.stateVersion = "25.11";
                home.packages = allScripts;
                home.file.".config/sounds" = {
                  source = ./assets/sounds;
                  recursive = true;
                };

                home.file."/pictures/wallpapers" = {
                  source = ./assets/wallpapers;
                  recursive = true;
                };

              }
              userFile
              stylix.homeModules.stylix
              inputs.ags.homeManagerModules.default
            ];
            extraSpecialArgs = {
              pkgs-master = import nixpkgs-master { inherit system; };
              pkgs-stable = import nixpkgs-stable { inherit system; };
              hostCfg = hostCfg;
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
