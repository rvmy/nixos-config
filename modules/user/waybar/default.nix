{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.waybar.enable = lib.mkEnableOption "Enable Waybar";
  config = lib.mkIf config.user.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          margin = "5";
          height = 25;
          spacing = 5;

          # Right Modules
          modules-right = [
            "tray"
            "custom/separator"
            "pulseaudio#microphone"
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "custom/notification"
          ];

          # Center Modules
          modules-center = [
            #   "hyprland/window"
            "clock"
          ];

          # Left Modules
          modules-left = [
            "custom/logo"
            "custom/separator"
            "hyprland/workspaces"
            "cava"
          ];

          "custom/expand-icon" = {
            "format" = " ";
            "tooltip" = false;
          };

          "custom/separator" = {
            "format" = "|";
            "tooltip" = false;
          };

          "hyprland/window" = {
            "format" = "{title} - {class}";
            "max-length" = 55;
          };
          "tray" = {
            icon-size = "12";
            spacing = "4";
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            format-source = " {volume}%";
            format-source-muted = " {volume}%";
            on-click = "mic-toggle";
            on-click-right = "pavucontrol";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
          };

          "pulseaudio" = {
            format = "󰋎 {volume}%";
            format-muted = "󰋐 {volume}%";
            #  on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            scroll-step = "5";
          };

          "clock" = {
            locale = "en_US.UTF-8";
            format = "{:%d/%m %I:%M %p}";
            format-alt = "{:L%d %B W%V %Y}";
            tooltip-format = "<span>{calendar}</span>";
            "calendar" = {
              "mode" = "month";
              "mode-mon-col" = 3;
              "on-click-right" = "mode";
              "format" = {
                "month" = "<span color='#ffead3'><b>{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b>{}</b></span>";
              };
            };
          };

          "cava" = {
            #"cava_config" = "$XDG_CONFIG_HOME/cava/cava.conf";
            "framerate" = 30;
            "autosens" = 1;
            "bars" = 14;
            "lower_cutoff_freq" = 50;
            "higher_cutoff_freq" = 10000;
            "method" = "pipewire";
            "source" = "auto";
            "stereo" = true;
            "bar_delimiter" = 0;
            "noise_reduction" = 0.77;
            "input_delay" = 2;
            "hide_on_silence" = true;
            "format-icons" = [
              "▁"
              "▂"
              "▃"
              "▄"
              "▅"
              "▆"
              "▇"
              "█"
            ];
            "actions" = {
              "on-click-right" = "mode";
            };
          };

          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            active-only = false;
            all-outputs = true;
            ignore-empty = false;
            disable-scroll = true;
            persistent-workspaces = {
              "*" = 5;
            };

          };

          "custom/logo" = {
            format = "";
            tooltip = false;
          };

          "network" = {
            format-ethernet = "󰱓 Network";
            format-disconnected = "󰅛 Disconnected";
            tooltip-format-ethernet = "{ifname}\nIP: {ipaddr}\n▼ {bandwidthDownBits}/s ▲ {bandwidthUpBits}/s";
            tooltip-format-disconnected = "Network Disconnected";
          };

          "cpu" = {
            interval = 5;
            format = " {usage}%";
            on-click = "kitty btop";
          };
          "memory" = {
            interval = 5;
            format = " {percentage}%";
          };

          "custom/notification" = {
            tooltip = true;
            format = "<span size='16pt'>{icon}</span>";
            "format-icons" = {
              notification = "󱅫";
              none = "󰂜";
              dnd-notification = "󰂠";
              dnd-none = "󰪓";
              inhibited-notification = "󰂛";
              inhibited-none = "󰪑";
              dnd-inhibited-notification = "󰂛";
              dnd-inhibited-none = "󰪑";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            "escape" = true;
          };
        }
      ];

      style = ''
        @define-color bg ${config.stylix.base16Scheme.base00};
        @define-color foreground ${config.stylix.base16Scheme.base05};
        * {
           font-family: "JetBrainsMono Nerd Font", "Segoe UI", sans-serif;
           border: none;
           padding: 0px;
           min-height: 0;
           transition: background-color .3s ease-out;
           font-weight: bold;
           font-size: 12px;
        }

        window#waybar  {
          background-color: transparent;
        }

        #waybar > box {
          border-radius: 7px;
          border: 1.5px solid rgba(255, 255, 255, 0.1);
          margin: 0px 2px 2px 2px;
          background-color: @bg;
          box-shadow: 0 1px 2px rgba(0, 0, 0, 1);
          min-height: 20px;
          transition-property: background-color;
          transition-duration: .5s;
        }

        .modules-left {
          margin-left: 4px;
        }

        .modules-right {
          margin-right: 4px;
        }

        button {
          box-shadow: inset 0 -3px transparent;
          border: none;
          border-radius: 0;
          transition: 0.3s ease-in-out;
        }

        button:hover {
          background: inherit;
        }

        #workspaces {
            margin: 0px 0px;
            transition: 0.1s ease;
            padding: 1px 4px;
        }


        #workspaces button {
          padding: 1px 2px;
          margin: 0px;
          color: alpha(@foreground, 0.65);
          border: none;
          opacity: 1.0;
          font-weight: 900;
          border: none;
          border-radius: 0;
        }


        #workspaces button.active {
          color: @bg;
          background-color: @foreground;
          transition: all 0.15s ease;
          padding: 1px 2px;
          opacity: 1.0;
        }

        #workspaces button.empty:hover,
        #workspaces button:hover {
            background: transparent;
            color: alpha(@foreground, 1);
            animation: ws_hover 20s ease-in-out 1;
            transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.empty {
          opacity: 0.4;
          color: alpha(@foreground, 0.45);
          transition: all 0.15s ease;
          padding: 1px 2px;
        }

        #workspaces button.empty.active {
          opacity: 0.4;
          background-color: @foreground;
          color: alpha(@background, 0.45);
          transition: all 0.15s ease;
          padding: 1px 2px;
        }

        #memory,
        #mpris,
        #cpu,
        #clock,
        #network,
        #pulseaudio,
        #custom-notification,
        #custom-logo {
          min-width: 12px;
          padding: 0 4px;
          margin: 1px 3px 1px 3px;
          opacity: 0.5;
        }

        #custom-separator {
          opacity: 0.2;
          padding-top: 2px;
          padding-left: 4px;
          padding-right: 4px;
        }

        tooltip {
          padding: 2px;
        }


        #clock:hover,
        #tray:hover,
        #cpu:hover,
        #memory:hover,
        #custom-notification,
        #network:hover,
        #custom-logo,
        #pulseaudio:hover {
          border-radius: 0px;
          opacity: 1;
          background-color: transparent;
          color: @foreground;
        }

        #pulseaudio.microphone.source-muted {
            color: #bf616a;
            background-color: transparent;
            background: none;
             opacity: 1;
        }
      '';

    };

  };
}
