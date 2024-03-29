let 
  pkgs =  import <nixpkgs> {};
in
{pkgs, ...} : {
  wgsl-analyzer = pkgs.callPackage ./wgsl_analyzer.nix {};
  wgsl-formatter = pkgs.callPackage ./wgsl_formatter.nix {};
}
