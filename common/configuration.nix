{ config, pkgs, lib, ... }:

{
  imports =
  [
    ./home.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.hoseong = {
    shell = pkgs.zsh;
    isNormalUser = true;
    hashedPassword = "$6$nsZoc4qtpDeiOqMA$l.RS/yzBkTtAe6PGcI7yNrbFY3SG8li95I3k6YyjTbM8VDaUzYw1QpVuCMFC6iJqVtZuGI37yvmWlYF4K0vrT/";
  };

  environment.systemPackages = with pkgs; [
    eza
    git
		gcc
    wget
    sshfs
    unzip
    gnupg
    killall

    gnumake
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    WLR_NO_HARDWARE_CURSORS="1";

    GTK_IM_MODULE="kime";
    QT_IM_MODULE="kime";

    GPG_TTY="\${TTY}";

    LESSHISTFILE="";

    ZDOTDIR="\${XDG_CONFIG_HOME}/zsh";
    GRADLE_USER_HOME="\${XDG_DATA_HOME}/gradle";

    EDITOR="nvim";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.pcscd.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  system.stateVersion = "23.05";
}
