{ config, pkgs, lib, ... }:

{
  imports =
  [
    ./home.nix
    ./audio.nix
    ./neovim.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.hardwareClockInLocalTime = true;

  hardware.opengl.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = false;

  boot.loader.timeout = 60;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint ="/boot/efi";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.enabled = "kime";
  };

  users.users.hoseong = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "docker" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    exa
    git
    wget
    sshfs
    unzip
    xclip
    gnupg
    killall
    distrobox

    sbt
  ];

  services.xserver = {
    enable = true;

    xkbOptions = "caps:super";

    windowManager.qtile.enable = true;

    displayManager = {
      defaultSession = "none+qtile";

      lightdm = {
        enable = true;
        extraConfig = ''
          user-authority-in-system-dir = true
        '';
      };

      autoLogin = {
        enable = true;
        user = "hoseong";
      };
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
    noto-fonts-cjk
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    XCOMPOSECACHE="\${XDG_CACHE_HOME}/X11/xcompose";
    ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors";

    GTK_IM_MODULE="kime";
    QT_IM_MODULE="kime";

    GPG_TTY="\${TTY}";

    LESSHISTFILE="";

    ZDOTDIR="\${XDG_CONFIG_HOME}/zsh";
    GRADLE_USER_HOME="\${XDG_DATA_HOME}/gradle";

    EDITOR="nvim";
    TERMINAL="alacritty";
    BROWSER="firefox";
  };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.pcscd.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  system.stateVersion = "23.05";
}
