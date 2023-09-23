{ config, pkgs, lib, ... }:

{
  imports =
  [
    ./home.nix
    ./audio.nix
    ./neovim.nix
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
  boot.loader.efi.efiSysMountPoint ="/boot/efi";

  boot.blacklistedKernelModules = [ "nouveau" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod.enabled = "kime";
  };

  users.users.hoseong.extraGroups = [ "wheel" "video" "docker" "networkmanager" ];

  environment.systemPackages = with pkgs; [
    dune_3
    ocaml
    ocamlPackages.menhir

    patchelf
    nix-index

    distrobox

    wl-clipboard
  ];

  services.xserver = {
    enable = true;
		videoDrivers = [ "nvidia" ];

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  programs.xwayland.enable = true;

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
    noto-fonts-cjk
  ];

  environment.sessionVariables = rec {
    TERMINAL="alacritty";
    BROWSER="firefox";
  };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
}
