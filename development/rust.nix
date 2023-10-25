{ inputs, ... }:

{
  environment.systemPackages = with inputs.unstable.legacyPackages.x86_64-linux; [
    cargo
    rustc
  ];
}
