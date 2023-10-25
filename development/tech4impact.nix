{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yarn
    nodejs_18
  ];

  services.mongodb.enable = true;
}
