{ inputs, pkgs, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    users.hoseong = {
      home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";

      gtk = {
        enable = true;
        cursorTheme.name = "capitaine-cursors-white";
        cursorTheme.package = pkgs.capitaine-cursors;
      };

      home.packages = with pkgs; [
        capitaine-cursors

        rofi-wayland

        evince
        firefox-bin
        alacritty

        wl-clipboard

        gnome.nautilus
      ];

      home.file.".config/alacritty" = {
        source = ./dotfiles/alacritty;
        recursive = true;
      };

      home.file.".config/rofi" = {
        source = ./dotfiles/rofi;
        recursive = true;
      };
    };
  };
}
