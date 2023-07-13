{ inputs, pkgs, ... }: 

{
  imports =
  [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };

    users.hoseong = {
      home = {
        username = "hoseong";
        homeDirectory = "/home/hoseong";
      };

      home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";

      home.packages = with pkgs; [
        capitaine-cursors

        gcc
        rustc
        cargo

        rofi

        evince
        firefox
        alacritty
        gnome.nautilus

        dconf

        zulip
      ];

      services.picom = {
        enable = true;
        backend = "glx";

        vSync = true;

        settings = {
          corner-radius = 10.0;
          round-borders = 1;
        };
      };

      home.file.".config/alacritty" = {
        source = ./dotfiles/alacritty;
        recursive = true;
      };

      home.file.".config/nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
      };

      home.file.".config/qtile" = {
        source = ./dotfiles/qtile;
        recursive = true;
      };

      home.file.".config/rofi" = {
        source = ./dotfiles/rofi;
        recursive = true;
      };

      home.file.".config/zsh" = {
        source = ./dotfiles/zsh;
        recursive = true;
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

      home.stateVersion = "23.05";
    };
  };
}
