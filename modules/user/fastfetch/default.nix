{
  config,
  lib,
  ...
}:
{
  options.user.fastfetch.enable = lib.mkEnableOption "FastFetch";
  config = lib.mkIf config.user.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = ../../../assets/anime.png;
          height = 12;
          width = 30;
          padding = {
            top = 2;
            left = 2;
          };
        };
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "de"
          "wm"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "break"
          "colors"
        ];
      };

    };

  };
}
