{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dune_3
    sphinx

    ocaml
    ocamlPackages.menhir
  ];
}
