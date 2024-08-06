return {
  -- add language servers to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      codelens = {
        enabled = true,
      },
      ---@type lspconfig.options
      servers = { -- language servers listed here will be automatically installed with mason and loaded with lspconfig
        ansiblels = {},
        ansiblelint = {},
        -- cssls = { settings = { css = { lint = { unknownAtRules = "ignore" } } } }, -- frontend
        -- cssmodules_ls = {}, -- frontend
        bashls = {},
        lua_ls = {},
        diagnosticls = {}, -- wrapper for running formatters and linters
        sqlls = {},
        dockerls = {},
        -- tsserver = {}, -- frontend
        -- eslint = {}, -- frontend
        jinja_lsp = {},
        jsonls = {},
        yamlls = {},
        yamllint = {},
        -- pyright = {},
        basedpyright = {}, -- a fork of pyright that does not require a NodeJS installation
      },
    },
  },
}
