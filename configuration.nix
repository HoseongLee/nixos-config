{ config, pkgs, lib, ... }:

{
  imports =
  [
    ./audio.nix
    ./neovim.nix
    /etc/nixos/hardware-configuration.nix
  ];

  time.hardwareClockInLocalTime = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };

  boot.loader.timeout = 60;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ hangul ];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  users.users.hoseong = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "zoom"
  ];

  environment.systemPackages = with pkgs; [
    exa
    git
    wget
    sshfs
    unzip
    gnupg
    killall

    gcc
    cargo
    rustc

    dmenu

    evince
    firefox
    alacritty

    gnome.nautilus
    fontforge-gtk

    capitaine-cursors

    powertop
    intel-gpu-tools

    zoom-us
  ];

  fonts.fonts = with pkgs; [
    font-awesome
    noto-fonts-cjk
    source-code-pro
  ];

  services.xserver = {
    enable = true;
    layout = "us";

    videoDrivers = [ "modesetting" ];

    useGlamor = true;

    libinput.enable = true;

    displayManager = {
      lightdm.extraConfig = ''
        user-authority-in-system-dir = true
      '';

      setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --off --output DP-3 --primary --size 1920x1080 --mode 1920x1080 --rate 120 --dpi 96
      '';

      sessionCommands = ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
          Xcursor.theme: capitaine-cursors-white
        ''}
      '';

      defaultSession = "none+qtile";

      job.logToFile = false;

      autoLogin.enable = true;
      autoLogin.user = "hoseong";
    };

    windowManager.qtile.enable = true;

  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    XCOMPOSECACHE="\${XDG_CACHE_HOME}/X11/xcompose";

    GTK_IM_MODULE="ibus";
    QT_IM_MODULE="ibus";
    XMODIFIERS="@im=ibus";

    GPG_TTY="\${TTY}";

    LESSHISTFILE="";

    ZDOTDIR="\${XDG_CONFIG_HOME}/zsh";
    GRADLE_USER_HOME="\${XDG_DATA_HOME}/gradle";

    EDITOR="nvim";
    TERMINAL="alacritty";
    BROWSER="firefox";
  };

  services.picom = {
    enable = true;
    vSync = true;
    experimentalBackends = true;
  };

  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  services.pcscd.enable = true;
  services.tlp.enable = true;

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "22.05";

}

