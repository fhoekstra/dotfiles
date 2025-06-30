return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  -- ft = "markdown", -- If you decide to lazy-load anyway
  opts = {},
  keys = {
    { "<leader>mdt", "<cmd>Markview toggle<CR>", desc = "Markdown: toggle this window" },
    { "<leader>mds", "<cmd>Markview splitToggle<CR>", desc = "Markdown: split toggle" },
  },
}
