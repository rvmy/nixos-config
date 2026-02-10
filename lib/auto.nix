{ lib }:
rec {
  importAll =
    path:
    if builtins.pathExists path then
      let
        entries = builtins.readDir path;
        validEntries = lib.filterAttrs (
          name: type:
          (type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name)
          || (type == "directory" && builtins.pathExists (path + "/${name}/default.nix"))
        ) entries;
      in
      map (name: path + "/${name}") (builtins.attrNames validEntries)
    else
      [ ];

  discoverHosts =
    hostsPath:
    if builtins.pathExists hostsPath then
      builtins.attrNames (lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostsPath))
    else
      [ ];

  discoverUser =
    hostPath:
    let
      cfg = import (hostPath + "/default.nix") {
        config = { };
        pkgs = import <nixpkgs> { };
        lib = import <nixpkgs> { }.lib;
      };
    in
    cfg.config.host.username;
}
