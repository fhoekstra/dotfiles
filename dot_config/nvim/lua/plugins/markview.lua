return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  -- ft = "markdown", -- If you decide to lazy-load anyway

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
  keys = {
    { "<leader>mdt", "<cmd>Markview toggle<CR>", desc = "Markdown: toggle this window" },
    { "<leader>mds", "<cmd>Markview splitToggle<CR>", desc = "Markdown: split toggle" },
  },
}
