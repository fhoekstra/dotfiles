-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

del("n", "<leader>l")
map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

local function wrap_as_markdown_link()
  local url = vim.fn.getreg("+")
  local start = vim.fn.getpos("v")
  local finish = vim.fn.getpos(".")
  local lines = vim.fn.getregion(start, finish, { type = "v" })
  local selected = table.concat(lines, "\n")

  vim.cmd("normal! d")
  vim.fn.setreg("+", url)
  local col = vim.fn.col(".")
  local line = vim.fn.line(".")
  vim.api.nvim_buf_set_text(0, line - 1, col - 1, line - 1, col - 1, { "[" .. selected .. "](" .. url .. ")" })
end

vim.keymap.set("v", "<leader>ml", function()
  wrap_as_markdown_link()
  vim.cmd("startinsert")
end, { desc = "Wrap as markdown link" })

vim.keymap.set("n", "<leader>ml", function()
  local esc = vim.api.nvim_replace_termcodes("viw<leader>ml", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
end, { desc = "Wrap word as markdown link" })
