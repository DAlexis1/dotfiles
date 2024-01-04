local opts = {
  ensure_installed = {
    "efm",
    "lua_ls",
    "bashls",
    "clangd",
    "rust_analyzer",
    "pyright",
  },
  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  lazy = false,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
