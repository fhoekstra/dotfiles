return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true, -- for hidden files
          },
        },
        hidden = true, -- for hidden files
        ignored = true, -- for .gitignore files
      },
    },
  },
}
