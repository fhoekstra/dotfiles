return {
  "lucidph3nx/nvim-sops",
  event = { "BufEnter" },
  opts = {},
  keys = {
    { "<leader>see", vim.cmd.SopsEncrypt, desc = "[S]OPS [E]ncryption [E]ncrypt" },
    { "<leader>sed", vim.cmd.SopsDecrypt, desc = "[S]OPS [E]ncryption [D]ecrypt" },
  },
}
