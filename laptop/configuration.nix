{ lib, pkgs, config, ... }:

{
  imports =
  [
    ./home.nix
  ];
 
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

  services.tlp.enable = true;

  services.xserver = {
    videoDrivers = [ "modesetting" ];

    dpi = 192;

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    displayManager = {
      setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP1 --primary --mode 3840x2160 --rate 60 --dpi 192
      '';
    };
  };

  environment.sessionVariables = rec {
    QTILE_SCALE = "2";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

}
