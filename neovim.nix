{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xclip

    nodePackages.pyright

    texlab
    texlive.combined.scheme-full

    (neovim.override {
      configure = {
        customRC = "luafile ~/.config/nvim/init.lua";
        packages.plugins = with pkgs.vimPlugins; {
          start = [
            onedark-vim
            lightline-vim
            nerdtree
            nvim-cmp
            cmp-path
            cmp-nvim-lsp
            nvim-lspconfig
            (nvim-treesitter.withPlugins (
	      plugins: with plugins; [
	        tree-sitter-nix
		tree-sitter-python
		tree-sitter-latex
	      ]
	    ))
          ];
          opt = [];
        };
      };
    })
  ];
}
