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

      # base00 = "#0b0e14";
      # base01 = "#131721";
      # base02 = "#202229";
      # base03 = "#3e4b59";
      # base04 = "#bfbdb6";
      # base05 = "#e6e1cf";
      # base06 = "#ece8db";
      # base07 = "#f2f0e7";
      # base08 = "#f07178";
      # base09 = "#ff8f40";
      # base0A = "#ffb454";
      # base0B = "#aad94c";
      # base0C = "#95e6cb";
      # base0D = "#59c2ff";
      # base0E = "#d2a6ff";
      # base0F = "#e6b450";
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

    opacity = {
      terminal = 0.90;
      applications = 0.95;
      popups = 0.95;
    };

    # fonts = {
    #   # monospace = {
    #   #   package = pkgs.jetbrains-mono;
    #   #   name = "JetBrains Mono";
    #   # };

    #   # sizes = {
    #   #   terminal = 12;
    #   # };
    # };

    targets = {
      waybar.enable = false;
      kitty.enable = true;
      hyprland.enable = true;
      ghostty.enable = true;
      starship.enable = false;
      gtk.enable = true;
      zed.enable = true;
    };
    image = hostCfg.host.stylixImage;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    # sansSerif = {
    #   package = pkgs.noto-fonts;
    #   name = "Noto Sans";
    # };

    # serif = {
    #   package = pkgs.noto-fonts;
    #   name = "Noto Serif";
    # };

    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      terminal = 10; # Ghostty, foot, alacritty
      applications = 11;
      desktop = 10;
      popups = 10;
    };
  };

  user.helix.enable = true;
  user.starship.enable = true;
  user.zed.enable = true;
  user.git.enable = true;
  user.ghostty.enable = true;
  user.fastfetch.enable = true;
  user.hyprland.enable = true;
  user.btop.enable = true;
  user.waybar.enable = true;
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
    cava
    dysk
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
