{ inputs, pkgs, lib, ... }: 

{
  imports =
  [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users.hoseong = {
      services.picom = {
        settings = {
          corner-radius = lib.mkForce 20.0;
          round-borders = lib.mkForce 2;
        };
      };
    };
  };
}
