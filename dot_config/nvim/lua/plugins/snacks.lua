return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            -- ignored = true,
          },
          grep = {
            hidden = true,
            -- ignored = true,
          },
        },
        -- optionally remap toggles to Ctrl-based keys:
        win = {
          input = {
            keys = {
              ["<C-y>"] = { "toggle_ignored", mode = { "i", "n" } },
              ["<C-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
