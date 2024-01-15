local opts = {
  ensure_installed = {
    "efm",
    "lua_ls",
    "clangd",
    "rust_analyzer",
    "pyright",
    "bashls",
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
