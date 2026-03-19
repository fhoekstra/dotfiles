local util = require("conform.util")
local ts_js_css_html_formatters = { "biome", "biome_fix", "biome-organize-imports" }
local yaml_formatters = { "prettier" }
return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      nix = { "nixfmt" },
      ansible = yaml_formatters,
      yaml = yaml_formatters,
      json = ts_js_css_html_formatters,
      javascript = ts_js_css_html_formatters,
      javascriptreact = ts_js_css_html_formatters,
      typescript = ts_js_css_html_formatters,
      typescriptreact = ts_js_css_html_formatters,
      html = ts_js_css_html_formatters,
      css = ts_js_css_html_formatters,
    },
    formatters = {
      biome_fix = {
        command = "node_modules/.bin/biome",
        args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
        stdin = true,
        cwd = util.root_file({ "biome.json", "biome.jsonc" }),
        require_cwd = true,
      },
    },
  },
}
