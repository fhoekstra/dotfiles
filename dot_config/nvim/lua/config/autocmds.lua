-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Jinja templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.y*ml.j2" },
  command = "set ft=jinja.yaml",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.j2" },
  command = "set ft=jinja",
})

-- Do not autoformat keymap files: the keys arrays are spaced out to visually represent the shape of the keyboard
-- Disable autoformat for keymap.c files
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "keymap.c" },
  callback = function()
    vim.b.autoformat = false
  end,
})
