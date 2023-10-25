{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    hyprland.url = "github:hyprwm/Hyprland/refs/tags/v0.30.0";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, NixOS-WSL, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./common/configuration.nix
        ./desktop/configuration.nix
        ./development/configuration.nix
      ];
    };

    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
        ./common/configuration.nix
        ./wsl/configuration.nix
        ./development/configuration.nix
        NixOS-WSL.nixosModules.wsl
      ];
    };
  };
}
