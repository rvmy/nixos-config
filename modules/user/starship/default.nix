{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.user.starship.enable = lib.mkEnableOption "Enable Startship";
  config = lib.mkIf config.user.starship.enable {
    programs.starship = {
      enable = true;

      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        format = ''
          [](primary)$os$username[](bg:primary-dark fg:primary)$directory[](bg:accent-yellow fg:primary-dark)$git_branch$git_status[](fg:accent-yellow bg:success-green)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:success-green bg:sapphire)$conda[](fg:sapphire bg:lavender)$time$character
        '';
        palette = "catppuccin_mocha";

        os = {
          disabled = false;
          style = "bg:primary fg:text-light";
          symbols = {
            Windows = "";
            Ubuntu = "󰕈";
            SUSE = "";
            Raspbian = "󰐿";
            Mint = "󰣭";
            Macos = "󰀵";
            Manjaro = "";
            Linux = "󰌽";
            Gentoo = "󰣨";
            Fedora = "󰣛";
            Alpine = "";
            Amazon = "";
            Android = "";
            AOSC = "";
            Arch = "󰣇";
            Artix = "󰣇";
            CentOS = "";
            Debian = "󰣚";
            Redhat = "󱄛";
            RedHatEnterprise = "󱄛";
          };
        };

        username = {
          show_always = true;
          style_user = "bg:primary fg:text-light";
          style_root = "bg:primary-dark fg:accent-yellow";
          format = "[ $user]($style)";
        };

        directory = {
          style = "bg:primary-dark fg:accent-yellow";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = "󰝚 ";
            Pictures = " ";
            Developer = "󰲋 ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:accent-yellow";
          format = "[[ $symbol $branch ](fg:primary-dark bg:accent-yellow)]($style)";
        };

        git_status = {
          style = "bg:accent-yellow";
          format = "[[($all_status$ahead_behind )](fg:primary-dark bg:accent-yellow)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        golang = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        php = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        kotlin = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        haskell = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version) ](fg:primary-dark bg:success-green)]($style)";
        };

        python = {
          symbol = "";
          style = "bg:success-green";
          format = "[[ $symbol( $version)(\\(#$virtualenv\\)) ](fg:primary-dark bg:success-green)]($style)";
        };

        conda = {
          symbol = "  ";
          style = "fg:primary-dark bg:sapphire";
          format = "[$symbol$environment ]($style)";
          ignore_base = false;
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:lavender";
          format = "[[  $time ](fg:primary-dark bg:lavender)]($style)";
        };

        line_break.disabled = true;

        character = {
          disabled = false;
          success_symbol = "[❯](bold fg:success-green)";
          error_symbol = "[❯](bold fg:error-red)";
          vimcmd_symbol = "[❮](bold fg:success-green)";
          vimcmd_replace_one_symbol = "[❮](bold fg:time-blue)";
          vimcmd_replace_symbol = "[❮](bold fg:time-blue)";
          vimcmd_visual_symbol = "[❮](bold fg:warning-orange)";
        };

        cmd_duration = {
          show_milliseconds = true;
          format = " in $duration ";
          style = "bg:time-blue";
          disabled = false;
          show_notifications = true;
          min_time_to_notify = 45000;
        };

        palettes = {
          catppuccin_mocha = {
            primary = "#0793CA";
            primary-dark = "#022F40";
            accent-yellow = "#FFC857";
            success-green = "#6FCF97";
            warning-orange = "#F2994A";
            error-red = "#EB5757";
            text-light = "#FFFFFF";
            text-dark = "#1E1E2E";
            time-blue = "#b4befe";
            secondary-purple = "#C678DD";
            sapphire = "#74c7ec";
            lavender = "#b4befe";
          };
        };
      };
    };
  };
}
