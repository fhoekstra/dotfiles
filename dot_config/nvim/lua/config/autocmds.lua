-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Ansible YML YAML
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/playbooks/*.y*ml",
    "*/tasks/*.y*ml",
    "*/roles/*/handlers/*.y*ml",
    "*/host_vars/*.y*ml",
    "*/group_vars/*.y*ml",
  },
  command = "set ft=yaml.ansible",
})

-- Jinja templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.y*ml.j2" },
  command = "set ft=jinja.yaml",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.j2" },
  command = "set ft=jinja",
})
