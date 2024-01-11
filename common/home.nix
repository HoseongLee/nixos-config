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

      home.file.".config/nvim" = {
        source = ./dotfiles/nvim;
        recursive = true;
      };

      home.file.".config/nvim/ftplugin/java.lua".text = ''
        local root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
        local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
        local data_dir = '/home/hoseong/.cache/' .. project_name
        local config = {
            cmd = {
              '${pkgs.jdk17}/bin/java',

              '-Declipse.application=org.eclipse.jdt.ls.core.id1',
              '-Dosgi.bundles.defaultStartLevel=4',
              '-Declipse.product=org.eclipse.jdt.ls.core.product',
              '-Dlog.protocol=true',
              '-Dlog.level=ALL',
              '-Xmx1g',
              '--add-modules=ALL-SYSTEM',
              '--add-opens', 'java.base/java.util=ALL-UNNAMED',
              '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

              '-jar', '/home/hoseong/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
              '-configuration', '/home/hoseong/jdtls/config_linux',
              '-data', data_dir,
            },
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-1.8",
                      path = "${pkgs.oraclejdk}/",
                    },
                    {
                      name = "JavaSE-17",
                      path = "${pkgs.jdk17}/lib/openjdk",
                    },
                  }
                }
              }
            }
        }
      
        require('jdtls').start_or_attach(config)
      '';

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
