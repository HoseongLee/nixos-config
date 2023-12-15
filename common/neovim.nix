{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (neovim.override {
      configure = {
        customRC = "luafile ~/.config/nvim/init.lua";
        packages.plugins = with pkgs.vimPlugins; {
          start = [
            onedark-vim
            lualine-nvim

            nerdtree

            nvim-lspconfig

            nvim-cmp
            cmp-path
            cmp-nvim-lsp
            cmp-nvim-lua
            cmp-vsnip
            vim-vsnip
            cmp-nvim-lsp-signature-help

            (nvim-treesitter.withPlugins (
              plugins: with plugins; [
                tree-sitter-nix
                tree-sitter-lua
              ]
            ))
          ];
        };
      };
    })
  ];
}
