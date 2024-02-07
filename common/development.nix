{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    (python311.withPackages (ps: with ps; [six]))
  ];

  services.mongodb.enable = true;
}
