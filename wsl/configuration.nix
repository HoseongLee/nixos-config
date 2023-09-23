{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
  ];

  nix.package = pkgs.nixFlakes;

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "hoseong";
    startMenuLaunchers = true;
    nativeSystemd = true;
  };

  users.users.hoseong.extraGroups = [ "wheel" ];
}
