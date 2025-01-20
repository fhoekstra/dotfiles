return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      nix = { "nixfmt" },
      ansible = { "prettier" },
      yaml = { "prettier" },
      json = { "biome" },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      html = { "biome" },
      css = { "biome" },
    },
  },
}
