return {
  "selimacerbas/markdown-preview.nvim",
  dependencies = { "selimacerbas/live-server.nvim" },
  keys = {
    { "<leader>mps", "<cmd>MarkdownPreview<cr>", desc = "Markdown: Start preview" },
    { "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown: Stop preview" },
    { "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", desc = "Markdown: Refresh preview" },
  },
  config = function()
    require("markdown_preview").setup({
      -- all optional; sane defaults shown
      instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
      port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
      open_browser = true,
      debounce_ms = 300,
      mermaid_renderer = "rust",
    })
  end,
}
