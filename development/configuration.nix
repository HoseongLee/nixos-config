{ pkgs, ... }:

{
  imports =
  [
    ./rust.nix
    ./ocaml.nix
		./tech4impact.nix
  ];

  environment.systemPackages = with pkgs; [
    slack

    texlive.combined.scheme-full
  ];
}
