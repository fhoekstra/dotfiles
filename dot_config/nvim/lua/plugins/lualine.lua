-- Hide the clock when inside a tmux window:
-- The tmux statusline already has a clock in the same place,
-- and the 'ticking' of the nvim clock registers as a change
-- to the window in tmux
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_z = {
        function()
          if not vim.env.TMUX or vim.env.TMUX == "" then
            return " " .. os.date("%R")
          else
            return ""
          end
        end,
      },
    },
  },
}
