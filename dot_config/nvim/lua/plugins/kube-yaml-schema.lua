return {
  "Sironheart/kube_yaml_schema.nvim",
  cmd = { "KubeYamlSchema" },
  opts = {
    auto_refresh = true,
    cache_ttl_seconds = 300,
  },
  config = function(_, opts)
    -- Setup the plugin
    require("kube-yaml-schema").setup(opts)

    vim.lsp.config("yamlls", require("kube_yaml_schema").yamlls_config())
  end,
}
