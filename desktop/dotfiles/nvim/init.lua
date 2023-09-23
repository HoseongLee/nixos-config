require("options")
require("bindings")
require("plugins")
require("autocmd")

require('lsp')

require('lualine').setup { options = { icons_enabled = false } }

--autocmd filetype c nnoremap <F5> :w<CR> :!make<CR><CR>

--autocmd filetype rust nnoremap <F5> :w<CR> :!rustc --edition 2021 -O -o bin %<CR>:sp<CR><C-w><C-w>:term<CR>:resize10<CR>i./bin<CR>
--autocmd filetype c nnoremap <F5> :w<CR> :sp<CR><C-w><C-w>:term<CR>:resize10<CR>i make<CR>
