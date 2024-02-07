{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";

    hyprland.url = "github:hyprwm/Hyprland/refs/tags/v0.34.0";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, NixOS-WSL, vscode-server, ... }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in

    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      overlays.custom-packages = final: _prev: import ./packages {pkgs = final;};

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs system; };

          modules = [
            ./common/configuration.nix
            ./desktop/configuration.nix
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs system; };

          modules = [
            vscode-server.nixosModules.default
            ./common/configuration.nix
            ./wsl/configuration.nix
            NixOS-WSL.nixosModules.wsl
          ];
        };
      };
    };
}
