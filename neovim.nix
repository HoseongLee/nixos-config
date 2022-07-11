{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xclip

    rnix-lsp

    sumneko-lua-language-server

    nodePackages.pyright

    texlab
    texlive.combined.scheme-full

    rust-analyzer

    (neovim.override {
      configure = {
        customRC = "luafile ~/.config/nvim/init.lua";
        packages.plugins = with pkgs.vimPlugins; {
          start = [
            onedark-vim
            lightline-vim

            nerdtree

            nvim-lspconfig

            nvim-cmp
            cmp-path
            cmp-nvim-lsp
            cmp-nvim-lua
            cmp-vsnip
            vim-vsnip

            (nvim-treesitter.withPlugins (
              plugins: with plugins; [
                tree-sitter-nix
                tree-sitter-lua
                tree-sitter-python
                tree-sitter-latex
              ]
            ))
          ];
        };
      };
    })
  ];
}
