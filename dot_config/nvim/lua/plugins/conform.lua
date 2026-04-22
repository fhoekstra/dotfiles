local ts_js_css_html_formatters = { "oxfmt" }
local yaml_formatters = { "oxfmt" }
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
  },
}
