{
  config,
  pkgs,
  pkgs-stable,
  ...
}:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Language
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = false;
  programs.niri.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # services.postgresql = {
  #   enable = true;
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all       all     trust
  #   '';

  #   # Initial script runs once when the database cluster is created
  #   initialScript = pkgs.writeText "backend-initScript" ''
  #     CREATE USER myuser WITH ENCRYPTED PASSWORD 'mypassword123';
  #     CREATE DATABASE mydatabase;
  #     GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;
  #     ALTER DATABASE mydatabase OWNER to myuser;
  #   '';

  # };

  # extraServices.podman.enable = true;
  services.xserver.digimend.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.flatpak.enable = true;


  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""

      if not set -q DEV_SHELL
          fastfetch
      end

      starship init fish | source
    '';

    shellAliases = {
      els = "eza --icons --group-directories-first";
      ell = "eza -l --icons --group-directories-first";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };


  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-niri-vram-fix.json".text = ''
    {
        "rules": [
            { "pattern": { "feature": "procname", "matches": "niri" },
              "profile": "Limit Free Buffer Pool On Wayland Compositors" }
        ],
        "profiles": [
            { "name": "Limit Free Buffer Pool On Wayland Compositors",
              "settings": [ { "key": "GLVidHeapReuseRatio", "value": 0 } ] }
        ]
    }
  '';


  boot.extraModprobeConfig = ''
    options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerDefault=0x1; PowerMizerDefaultAC=0x1; PerfLevelSrc=0x2222"
  '';

  boot.kernel.sysctl."vm.max_map_count" = 1048576;
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    fuzzel
    waybar
    noctalia-shell
    ffmpeg-full
    # vim
    # wget
    # gtk3
    # gtk4
    # thunar-volman
    # thunar-archive-plugin
    # ffmpeg
    appimage-run
    distrobox
  ];

  users.users.rami = {
    isNormalUser = true;
    description = "rami";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.virtualisation.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
