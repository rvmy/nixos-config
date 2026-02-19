{
  config,
  pkgs,
  pkgs-master,
  pkgs-stable,
  lib,
  hostCfg,
  ...
}:

{

  programs.ags = {
    enable = true;
    configDir = ../../ags;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = [ "mpv.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
    };
  };
  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs-stable.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs-stable.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = true;

    base16Scheme = {
      scheme = "Stylix Blue Custom";
      author = "you";
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

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 10;
        applications = 11;
        desktop = 10;
        popups = 10;
      };
    };
    targets = {
      waybar.enable = false;
      kitty.enable = true;
      hyprland.enable = true;
      ghostty.enable = true;
      starship.enable = false;
      gtk = {
        enable = true;

        #flatpakSupport.enable = true;
      };
      zed.enable = true;
      rofi.enable = true;
      yazi.enable = true;
      qt = {
        enable = true;
        platform = "qtct";
      };
      kde.enable = true;
    };
  };

  programs.feh = {
    enable = true;

    themes = {
      feh = [
        "--full-screen"
      ];
    };
    buttons = {
      zoom_in = "4";
      zoom_out = "5";
    };
    keybindings = {
      prev_img = [
        "h"
        "Left"
      ];
      next_img = [
        "l"
        "Right"
      ];

    };
    # themes = {
    #   wallpaper = "--bg-scale --no-fehbg";
    # };
  };
  ## Yazi File Manager
  programs.yazi = {
    enable = true;

    keymap.mgr.prepend_keymap = [
      {
        on = [ "w" ];
        run = ''
          shell "
            img=\"$0\"
            case \"$img\" in
              *.png|*.jpg|*.jpeg|*.webp)
                swww img \"$img\" --transition-type any
                ;;
            esac
          "
        '';
        desc = "Set hovered image as wallpaper";
      }

    ];
    settings = {
      mgr = {

        ratio = [
          2
          2
          3
        ];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = false;
        show_symlink = false;
      };

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
  user.rofi.enable = true;

  # home.file.".config/qt5ct/qt5ct.conf".text = ''
  #   [Appearance]
  #   icon_theme=Tela-purple-dark
  #   style=Breeze
  # '';

  xdg.configFile."menus/applications.menu".source =
    "${pkgs-stable.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  programs.kitty = {
    enable = true;
    extraConfig = "";
    settings = {
      confirm_os_window_close = 0;
    };
    font = {
      name = lib.mkForce "JetBrainsMono Nerd Font";
      size = lib.mkForce 11;
    };
  };
  nixpkgs.config.allowUnfree = true;
  #  programs.firejail.enable = true;
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    #  noto-fonts-emoji
    swaynotificationcenter
    libnotify
    firejail
    copyq
    grim
    nautilus
    ffmpeg
    kdePackages.ffmpegthumbs
    slurp
    krita
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
    # pkgs-stable.kdePackages.kio
    # pkgs-stable.kdePackages.kio-fuse
    # pkgs-stable.kdePackages.kio-extras
    # pkgs-stable.kdePackages.qtsvg
    kdePackages.dolphin
    #  pkgs-stable.kdePackages.kconfigwidgets
    #  pkgs-stable.kdePackages.systemsettings
    #   pkgs-stable.kdePackages.plasma-integration
    #  pkgs-stable.kdePackages.kservice
    #   pkgs-stable.kdePackages.kconfig
    #  pkgs-stable.kdePackages.plasma-workspace
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.qtsvg

    libsForQt5.qt5ct
    dysk
    pastel
    calcure
    eww
    fd
    qutebrowser
    blender
    gimp
    pkgs-stable.kdePackages.kdenlive
    nemo
    davinci-resolve
    flameshot
    satty
    easyeffects

    # fastfetch
    # mpd
    # rmpc
    # spotifyd
    # spotify-player
    #librespot
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    #  kdePackages.breeze
    # pkgs-stable.kdePackages.qt6ct
    pkgs-stable.kdePackages.qtwayland
    # pkgs-stable.kdePackages.plasma-integration
    # pkgs-stable.kdePackages.systemsettings
    #   kdePackages.breeze-icons
  ];

  programs.cava = {
    enable = true;
    settings = {
      general = {
        bar_spacing = 1;
        bar_width = 2;
        frame_rate = 60;
      };
      color = {

        gradient = 1;
        gradient_color_1 = "'#8BE9FD'";
        gradient_color_2 = "'#9AEDFE'";
        gradient_color_3 = "'#CAA9FA'";
        gradient_color_4 = "'#BD93F9'";
        gradient_color_5 = "'#FF92D0'";
        gradient_color_6 = "'#FF79C6'";
        gradient_color_7 = "'#FF6E67'";
        gradient_color_8 = "'#FF5555'";
      };
    };
  };

  gtk = {
    iconTheme = {
      name = "Tela-purple-dark";
      package = pkgs.tela-icon-theme;
    };
  };

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
