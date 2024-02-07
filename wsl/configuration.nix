{ pkgs, config, ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";
  nix.package = pkgs.nixFlakes;

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "hoseong";
    startMenuLaunchers = true;
    nativeSystemd = true;
  };

  hardware.opengl = {
    enable = true;
    package = pkgs.mesa.drivers;
    extraPackages = [ pkgs.mesa.drivers ];
  };

  environment.systemPackages = with pkgs; [
    glib
    distrobox
  ];

  services.vscode-server.enable = true;

  users.users.hoseong.extraGroups = [ "wheel" ];
}
