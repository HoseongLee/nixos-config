local map = vim.keymap

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function()
    map.set('n', '<F5>', ':w<CR>:!python3 %<CR>')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex' },
  callback = function()
    map.set('n', '<F5>', ':w<CR>:!pdflatex %<CR>')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'nix', 'lua' },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})
