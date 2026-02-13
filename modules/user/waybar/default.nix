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
          margin = "10";
          height = 30;
          spacing = 5;
          modules-left = [
            "tray"
            "clock"
            "pulseaudio#microphone"
            "pulseaudio"
          ];

          modules-center = [ "hyprland/workspaces" ];

          modules-right = [
            "network"
            "cpu"
            "memory"
            "custom/notification"
            "custom/logo"
          ];

          "tray" = {
            icon-size = "18";
            spacing = "10";
          };

          "clock" = {
            format = "󰥔 {:%I:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "󰃭 {:%a; %d %b}";
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

          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            active-only = false;
            all-outputs = true;
            ignore-empty = false;
            persistent-workspaces = {
              "*" = 5;
            };

            "format-icons" = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "default" = "";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

          "custom/logo" = {
            format = "";
            #  "on-click" = "~/.config/rofi/launchers/type-1/launcher.sh || pkill rofi";
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
        @define-color sec-bg ${config.stylix.base16Scheme.base02};
        @define-color fg ${config.stylix.base16Scheme.base05};
        * {
          border: none;
          font-family: "JetBrainsMono Nerd Font", "Segoe UI", sans-serif;
          font-size: 13px;
          font-weight: 500;
          min-height: 0;
        }

        window#waybar {
          background-color: @bg;
          color: #c0caf5;
          border-radius: 20px;
          padding: 0;
          margin: 0;
        }

        /* Unified module styling */
        #workspaces,
        #tray,
        #clock,
        #pulseaudio,
        #pulseaudio.microphone,
        #network,
        #cpu,
        #memory,
        #custom-notification,
        #custom-logo {
          background-color: @sec-bg;
          color: #c0caf5;
          padding: 0 16px;
          margin: 4px;
          border-radius: 12px;
        }

        /* Workspaces */
        #workspaces button {
          color: #565f89;
          padding: 0 10px;
          border-radius: 12px;
          margin: 0 2px;
        }

        #workspaces button:not(.empty) {
          color: #c0caf5;
        }


        #workspaces button.active {
          color: #7aa2f7;
          background-color: rgba(122, 162, 247, 0.15);
          font-weight: bold;
        }

        /* Muted states */
        #pulseaudio.muted,
        #pulseaudio.microphone.muted {
          color: #f7768e;
          background-color: rgba(247, 118, 142, 0.1);
        }

        /* Notification module */
        #custom-notification {
          padding: 0 12px;
        }

        /* Hover effects */
        #pulseaudio:hover,
        #pulseaudio.microphone:hover,
        #clock:hover,
        #custom-logo:hover {
          background-color: rgba(65, 72, 104, 0.9);
        }

        /* Battery (only if module exists) */
        #battery.warning {
          color: #e0af68;
        }

        #battery.critical {
          color: #f7768e;
          animation: blink 1s linear infinite;
        }

        @keyframes blink {
          50% { opacity: 0.3; }
        }
      '';
    };

  };
}
