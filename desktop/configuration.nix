{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [
      ./home.nix
      ./audio.nix
      ./hardware-configuration.nix
    ];

  time.hardwareClockInLocalTime = true;

  hardware.opengl.enable = true;

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = false;

  boot.loader.timeout = 60;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.blacklistedKernelModules = [ "nouveau" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.enabled = "kime";
  };

  users.users.hoseong.extraGroups = [ "wheel" "video" "networkmanager" ];

  environment.systemPackages = with pkgs; [
    patchelf
    nix-index

    distrobox
    zulip

    wl-clipboard
  ];

  programs.hyprland.enable = true;
  programs.xwayland.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
    noto-fonts-cjk
  ];

  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    BROWSER = "firefox";

    CARGO_HOME = "\${XDG_DATA_HOME}/cargo";
    CUDA_CACHE_PATH = "\${XDG_CACHE_HOME}/nv";
  };
}
