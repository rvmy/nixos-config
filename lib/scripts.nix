# lib/scripts.nix
{ lib, pkgs }:
let
  mkScriptsFromDir =
    scriptsPath:
    let
      scriptsExist = builtins.pathExists scriptsPath;

      commonDeps = with pkgs; [
        coreutils
        wireplumber
        libnotify
        pipewire
        grim
        slurp
        wl-clipboard
      ];

      buildScripts =
        scriptDir:
        let
          scriptEntries = builtins.readDir scriptDir;
          shellScripts = lib.pipe scriptEntries [
            builtins.attrNames
            (builtins.filter (name: scriptEntries.${name} == "regular"))
            (builtins.filter (name: lib.hasSuffix ".sh" name))
          ];

          mkScript =
            name:
            pkgs.writeShellApplication {
              name = lib.removeSuffix ".sh" name;
              text = builtins.readFile (scriptDir + "/${name}");
              runtimeInputs = commonDeps;
            };
        in
        map mkScript shellScripts;
    in
    if scriptsExist then buildScripts scriptsPath else [ ];
in
{
  inherit mkScriptsFromDir;
}
