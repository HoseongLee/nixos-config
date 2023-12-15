{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";

    hyprland.url = "github:hyprwm/Hyprland/refs/tags/v0.32.3";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, NixOS-WSL, ... }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in

    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs system; };

        modules = [
          ./common/configuration.nix
          ./desktop/configuration.nix
        ];
      };

      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };

        modules = [
          ./common/configuration.nix
          ./wsl/configuration.nix
          NixOS-WSL.nixosModules.wsl
        ];
      };
    };
}
