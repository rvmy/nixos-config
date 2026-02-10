{
  config,
  pkgs,
  pkgs-master,
  lib,
  ...
}:

{

  stylix = {
    # enable = true;
    opacity = {
      terminal = 0.90;
      applications = 0.95;
      popups = 0.95;
    };
    targets = {
      waybar.enable = true;
      kitty.enable = true;
      # waybar.enable = false;
      # rofi.enable = false;
      # hyprland.enable = false;
      # hyprlock.enable = false;
      # ghostty.enable = false;
      # qt.enable = true;
    };
  };

  fonts.fontconfig.enable = true;

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
