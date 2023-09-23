{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, NixOS-WSL, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./common/configuration.nix
        ./desktop/configuration.nix
      ];
    };

    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
        ./common/configuration.nix
        ./wsl/configuration.nix
        NixOS-WSL.nixosModules.wsl
      ];
    };
  };
}
