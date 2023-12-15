{ inputs, pkgs, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home-manager = {
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs; };

    users.hoseong = {
      home = {
        username = "hoseong";
        homeDirectory = "/home/hoseong";
      };

      home.packages = with pkgs; [
      ];

      home.file.".config/zsh" = {
        source = ./dotfiles/zsh;
        recursive = true;
      };

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";
        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
        ];
      };

      programs.git = {
        enable = true;

        userName = "HoseongLee";
        userEmail = "leehs.git@gmail.com";
      };

      programs.home-manager.enable = true;

      home.stateVersion = "23.11";
    };
  };
}
