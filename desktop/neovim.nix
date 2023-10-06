{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    ccls
    texlab
    rust-analyzer

    texlive.combined.scheme-full

    nodePackages.pyright
    nodePackages.typescript-language-server

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
                tree-sitter-tsx
                tree-sitter-lua
                tree-sitter-java
                tree-sitter-rust
                tree-sitter-latex
                tree-sitter-python
              ]
            ))
          ];
        };
      };
    })
  ];
}
