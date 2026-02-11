{
  config,
  pkgs,
  pkgs-master,
  lib,
  hostCfg,
  ...
}:

{

  stylix = {
    # enable = true;
    enable = true;
    polarity = "dark";
    autoEnable = true;

    base16Scheme = {
      scheme = "Stylix Blue Custom";
      author = "you";

      base00 = "#081522"; # Deep Navy (background)
      base01 = "#0B1C2D"; # Dark Blue
      base02 = "#102A43"; # Midnight Blue
      base03 = "#1C3A5F"; # Slate Blue
      base04 = "#6B7C93"; # Muted Gray
      base05 = "#E6EDF3"; # Off White (text)
      base06 = "#B0BEC5"; # Light Gray
      base07 = "#FFFFFF";

      base08 = "#EB5757"; # Red
      base09 = "#F2994A"; # Orange
      base0A = "#F2C94C"; # Amber
      base0B = "#2BB0A6"; # Teal
      base0C = "#2D9CDB"; # Cyan
      base0D = "#2F80ED"; # Stylix Blue
      base0E = "#BB6BD9"; # Magenta
      base0F = "#56A0FF"; # Soft Blue
    };

    opacity = {
      terminal = 0.90;
      applications = 0.95;
      popups = 0.95;
    };
    targets = {
      waybar.enable = false;
      kitty.enable = true;
      hyprland.enable = true;
      starship.enable = false;
      gtk.enable = true;
      zed.enable = true;
    };
    image = hostCfg.host.stylixImage;
  };

  user.helix.enable = true;
  user.starship.enable = true;
  user.zed.enable = true;
  user.git.enable = true;
  user.ghostty.enable = true;
  user.fastfetch.enable = true;
  user.hyprland.enable = true;
  programs.kitty = {
    enable = true;
    extraConfig = "";
  };
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    #  noto-fonts-emoji
    swaynotificationcenter
    libnotify
    copyq
    grim
    nautilus
    #helix
    slurp
    wl-clipboard
    ghidra
    vscodium
    nil
    nixd
    insomnia
    feh
    rmpc
    pkgs-master.yt-dlp
    bat
    # dysk
    pastel
    calcure
    # fastfetch
    # mpd
    # rmpc
    # spotifyd
    # spotify-player
    #librespot
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/rami/mpd/audio";
    playlistDirectory = "/home/rami/mpd/playlists";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
    network.startWhenNeeded = true;
  };

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
