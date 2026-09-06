{
  config,
  pkgs,
  pkgs-master,
  pkgs-stable,
  lib,
  hostCfg,
    packages,
  ...
}:

{


  # programs.ags = {
  #   enable = true;
  #   configDir = ../../ags;
  # };

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "video/mp4" = [ "mpv.desktop" ];
  #     #  "video/x-matroska" = [ "mpv.desktop" ];
  #     #    "video/webm" = [ "mpv.desktop" ];
  #     #  "video/avi" = [ "mpv.desktop" ];
  #     "audio/mpeg" = [ "mpv.desktop" ];
  #     #  "audio/flac" = [ "mpv.desktop" ];
  #     "image/png" = [ "feh.desktop" ];
  #     "image/jpeg" = [ "feh.desktop" ];
  #     "image/webp" = [ "feh.desktop" ];
  #   };
  # };
  # programs.obs-studio = {
  #   enable = true;

  #   # optional Nvidia hardware acceleration
  #   package = (
  #     pkgs-stable.obs-studio.override {
  #       cudaSupport = true;
  #     }
  #   );

  #   plugins = with pkgs-stable.obs-studio-plugins; [
  #     wlrobs
  #     obs-backgroundremoval
  #     obs-pipewire-audio-capture
  #     obs-vaapi # optional AMD hardware acceleration
  #     obs-gstreamer
  #     obs-vkcapture
  #   ];
  # };

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

        flatpakSupport.enable = true;
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

    programs.feh.enable = true;

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
  user.btop.enable = true;

  # user.hyprland.enable = true;
  # user.waybar.enable = true;
  # user.rofi.enable = true;

  # programs.kitty = {
  #   enable = true;
  #   extraConfig = "";
  #   settings = {
  #     confirm_os_window_close = 0;
  #   };
  #   font = {
  #     name = lib.mkForce "JetBrainsMono Nerd Font";
  #     size = lib.mkForce 11;
  #   };
  # };


  nixpkgs.config.allowUnfree = true;

  home.packages = [
    ## -- Browsers
    pkgs.qutebrowser
    # packages.helium

    ## -- File Managers
    pkgs.nautilus
    pkgs.nemo
    pkgs.ranger
    pkgs.kdePackages.dolphin

    ## -- Terminals
    pkgs.alacritty
    pkgs.kitty
    pkgs.foot
    pkgs.wezterm

    ## -- Cybersecurity Tools
    pkgs.ghidra
    pkgs.wireshark
    pkgs.firejail

    ## -- Creative Tools
    pkgs.blender
    pkgs.inkscape
    pkgs.gimp
    pkgs.davinci-resolve
    pkgs-stable.kdePackages.kdenlive
    pkgs.krita

    ## -- Terminal Tools
    pkgs.pastel # -- color tool.
    pkgs.bat # -- alternative to cat.
    pkgs.fd # -- alternative to find.
    pkgs.dysk # -- utility listing your filesystems and disk.
    pkgs.dust # -- alternative to du.
    pkgs.duf # -- disk usage utility.
    pkgs.eza # -- alternative to ls.
    pkgs.fzf # -- interactive fuzzy finder.
    pkgs.caligula # -- tool to flash usb.
    pkgs.zoxide # -- zoxide is a smarter cd command.

    ## -- Others
    pkgs.xwayland-satellite
    pkgs.gparted
    pkgs.feh
    pkgs.nil
    pkgs.nix-init
    pkgs.nixd
    pkgs-master.yt-dlp
    pkgs.devenv

    #hyprpicker
    #podman-tui
    #satty
    #easyeffects
    pkgs.rmpc

  ];



  # xdg.configFile."menus/applications.menu".source =
  #   "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";


  programs.swaylock.enable = true;
  services.polkit-gnome.enable = true; # polkit
  programs.mpv = {
    enable = true;

    # scripts = with pkgs.mpvScripts; [
    #   # other scripts you might have
    #   uosc
    #   thumbfast
    #   sponsorblock
    # ];
  };


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

  # gtk = {
  #   iconTheme = {
  #     name = "Tela-purple-dark";
  #     package = pkgs.tela-icon-theme;
  #   };
  # };

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
