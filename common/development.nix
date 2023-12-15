{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    slack
    texlive.combined.scheme-full
  ];

  services.mongodb.enable = true;
}
