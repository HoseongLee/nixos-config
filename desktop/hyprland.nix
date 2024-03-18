{ unstable,  ... }:

{
  disabledModules = [
      "programs/hyprland.nix"
  ];

	imports = [
      "${unstable}/nixos/modules/programs/wayland/hyprland.nix"
	];

  programs.xwayland.enable = true;
  programs.hyprland.enable = true;
}
